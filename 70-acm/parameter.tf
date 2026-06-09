resource "aws_ssm_parameter" "aws_certificate_arn" {
  name  = "/${var.project}/${var.env}/aws_certificate_arn"
  type  = "String"
  value = aws_acm_certificate.krishnadev.arn
}
