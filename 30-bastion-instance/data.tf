data "aws_ami" "redhat" {
    most_recent      = true
    owners           = ["973714476881"]

    filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "public_subnet_id" {
  name = "/${var.project}/${var.env}/public_subnet_id"
}

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.env}/bastion_sg_id"
}