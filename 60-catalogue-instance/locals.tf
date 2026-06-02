locals {
    private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_id.value)[0]
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}