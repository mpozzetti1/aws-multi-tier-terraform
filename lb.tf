# Network Load Balancer (NLB) - TCP
resource "aws_lb" "web-lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "network"  # NLB
  subnets            = [aws_subnet.webPublic1.id, aws_subnet.webPublic2.id]
  security_groups    = [aws_security_group.sg-lb.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web-tg" {
  name     = "web-tg"
  port     = 80
  protocol = "TCP"  # Must be TCP/UDP for NLB
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "web-lis" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = 80
  protocol          = "TCP"  # Must be TCP/UDP for NLB

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

# Application Load Balancer (ALB) - HTTP/HTTPS
resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"  # ALB
  subnets            = [aws_subnet.appPrivate1.id, aws_subnet.appPrivate2.id]
  security_groups    = [aws_security_group.sg-lb.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app-tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"  # Can be HTTP/HTTPS for ALB
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "app-lis" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"  # Can be HTTP/HTTPS for ALB

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}