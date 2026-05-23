module "vpc"{
    source = "../../aws-vpc-module-terraform"
    project = var.project
    env = var.env
    vpc_peering = true
}