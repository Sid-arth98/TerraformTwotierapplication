# Terraform Two tier application
Practice for terraform 

 created Two modules -> VPC and EC2instance


File structure
+--- .gitignore
+--- ignorefile
+--- README.md

+--- main.tf
+--- output.tf
+--- provider.tf
+--- terraform.tfvars
+--- variable.tf
+--- **ec2instance**
|   +--- elb.tf
|   +--- instance.tf
|   +--- output.tf
|   +--- variable.tf
+--- **VPC**
|   +--- output.tf  
|   +--- variable.tf
|   +--- vpc.tf


VPC module:
  Created a VPC , 2 subnets ,internetgateway,routetable and attached the subnet to route table and connected to internet gateway

Ec2instance:
  created a instance in each subnets, created keypair and attached security group and installed web server(httpd) and loaded a sample file.
  created application loadbalancer ,target group and attached the instance to the target group , added this listener to loadbalancer  
  
                    
