resource "aws_ssm_parameter" "frontend_lb_listener_arn" {
  name  = "/${var.project}/${var.env}/frontend_lb_listener_arn"
  type  = "String"
  value = aws_lb_listener.https.arn
}
