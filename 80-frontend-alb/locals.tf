locals {
    public_subnet_id = split(",",data.aws_ssm_parameter.public_subnet_id.value)
    frontend_ALB_sg_id = data.aws_ssm_parameter.frontend_ALB_sg_id.value
    aws_certificate_arn = data.aws_ssm_parameter.aws_certificate_arn.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}