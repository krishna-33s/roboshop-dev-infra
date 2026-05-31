locals {
    private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_id.value)
    backend_alb_sg_id = data.aws_ssm_parameter.backend_ALB_sg_id.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}