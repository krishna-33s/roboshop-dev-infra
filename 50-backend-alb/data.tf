data "aws_ssm_parameter" "backend_ALB_sg_id" {
  name = "/${var.project}/${var.env}/backend_ALB_sg_id"
}

data "aws_ssm_parameter" "private_subnet_id" {
  name = "/${var.project}/${var.env}/private_subnet_id"
}