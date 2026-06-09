# Application Load Balancer
resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb-${var.project}-${var.env}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.frontend_ALB_sg_id]
  subnets            = local.public_subnet_id

  # true means we can't delete load balancer with terrraform
  enable_deletion_protection = false

  tags = merge(
    {
        Name = "frontend-alb-${var.project}-${var.env}"
    },
    local.common_tags
  )
}

# creating listener https:443
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPs"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.aws_certificate_arn

  
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h3> hii this frontend-alb listener with https:443 port.this server is fine</h3>"
      status_code  = "200"
    }
  }
}

# route 53 record
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "*.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}