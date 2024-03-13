variable "vpc_cidr" {
  default = "10.0.0.0/24"
}
variable "app_name" {
  default = "web_app"
}

variable "availability_zone" {
  default = ["ap-southeast-1a","ap-southeast-1b"]
}
