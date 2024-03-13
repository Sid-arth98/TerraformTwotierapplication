variable "ami" {
  default = "ami-001440bcc4ddffcf1"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "app_name" {
  default = "web_app"
}
variable "web_app_subnet_id" {
  
}
variable "web_app_vpc_id" {
  
}
variable "lb_target_group_type" {
  default = "instances"
}

variable "httpprotocol" {
  default = "HTTP"
}
variable "lb_type" {
  default = "application"
}
variable "http_port" {
  default = 80
}