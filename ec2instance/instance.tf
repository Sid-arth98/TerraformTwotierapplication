#instance creation
resource "aws_instance" "web_app_instance" {
  ami = var.ami
  instance_type = var.instance_type
  count = length(var.web_app_subnet_id)
  subnet_id = var.web_app_subnet_id[count.index]
  security_groups= [ aws_security_group.web_app_sg.id ]
  key_name =  aws_key_pair.public_key.key_name
  connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file(local_file.private_key.filename)
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo yum update ",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo echo 'hello world'> /var/www/html/index.html"
     ]
  }
  tags = {
    Name="${var.app_name}_instance_${count.index}"
  }
}

#security group for instance
resource "aws_security_group" "web_app_sg" {
    name_prefix = "${var.app_name}_sg"
    vpc_id = var.web_app_vpc_id
    description = "this is open all ingress and egress"
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
}

#keycreation
resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits = 4096
}

#publickey attach
resource "aws_key_pair" "public_key" {
  public_key = tls_private_key.keypair.public_key_openssh
  key_name = "${var.app_name}_public_key"
}

resource "local_file" "private_key" {
  filename = "tffile"
  content = tls_private_key.keypair.private_key_pem
}