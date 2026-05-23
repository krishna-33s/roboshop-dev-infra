module "vpc"{
    source = "git::https://github.com/krishna-33s/aws-vpc-module-terraform.git?ref=main"
    project = var.project
    env = var.env
    vpc_peering = true
}