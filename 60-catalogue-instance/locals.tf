locals {
    ami_id = data.aws_ami.redhat.id
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_id.value)[0]
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    backend_lb_listener_arn = data.aws_ssm_parameter.backend_lb_listener_arn.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}