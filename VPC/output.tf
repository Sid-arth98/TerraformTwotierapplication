output "subnet_id" {
  value = aws_subnet.web_app_subnet.*.id
}
output "vpc_id" {
  value = aws_vpc.web_app_vpc.id
}