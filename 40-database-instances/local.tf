locals {
    ami_id = data.aws_ami.redhat.id
    public_subnet_id = split(",",data.aws_ssm_parameter.database_subnet_id.value)[0]
    bastion_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}