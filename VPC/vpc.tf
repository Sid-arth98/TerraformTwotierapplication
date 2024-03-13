#VPC creation
resource "aws_vpc" "web_app_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.app_name}_vpc"
  }
}

#subnet creation
resource "aws_subnet" "web_app_subnet" {
  vpc_id = aws_vpc.web_app_vpc.id
  count=length(var.availability_zone)
  availability_zone = element(var.availability_zone,count.index)  
  cidr_block = cidrsubnet(var.vpc_cidr,2,count.index)
  map_public_ip_on_launch = true
  tags={
    Name = "web_app_public_subnet_${count.index}"
  }
}

#internet gateway creation
resource "aws_internet_gateway" "web_app_igw" {
  vpc_id = aws_vpc.web_app_vpc.id
}

#route table creation
resource "aws_route_table" "web_app_rt" {
  vpc_id = aws_vpc.web_app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_app_igw.id
  }
  tags = {
    Name="${var.app_name}_rt"
  }
}

#route table association 
resource "aws_route_table_association" "web_app_rt_association" {
   count= length(aws_subnet.web_app_subnet.*.id)
  route_table_id = aws_route_table.web_app_rt.id
  subnet_id = aws_subnet.web_app_subnet[count.index].id
}

