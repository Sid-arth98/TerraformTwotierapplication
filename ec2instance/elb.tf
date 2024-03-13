#target group creation

resource "aws_lb_target_group" "web_app_lb_target_group" {
  target_type = var.lb_target_group_type #"instance"
  protocol = var.httpprotocol
  #protocol_version = "HTTP1"
  port = var.http_port
  ip_address_type = "ipv4"
  vpc_id = var.web_app_vpc_id
  slow_start = 30

  load_balancing_algorithm_type = "round_robin"
  stickiness {
    enabled = false 
    type = "lb_cookie"
  }
  health_check {
    enabled = true
    protocol = var.httpprotocol
    path = "/"
    port = var.http_port
    matcher = "200"
    interval = 60
    healthy_threshold = 5
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.app_name}_tg"
  }
}

#attaching instance to target group
resource "aws_lb_target_group_attachment" "web_app_target_group_attachment" {
  target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  count = length(aws_instance.web_app_instance.*.id)
  target_id = aws_instance.web_app_instance[count.index].id
}

resource "aws_lb" "web_app_lb" {
  load_balancer_type = var.lb_type
  subnets = var.web_app_subnet_id
  internal = false
  security_groups = [aws_security_group.web_app_sg.id]
  tags = {
    Name = "${var.app_name}_lb"
  }
}

resource "aws_lb_listener" "web_app_lb_listerner" {
  load_balancer_arn = aws_lb.web_app_lb.arn
  port = var.http_port
  protocol = var.httpprotocol
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_app_lb_target_group.arn
  }
}