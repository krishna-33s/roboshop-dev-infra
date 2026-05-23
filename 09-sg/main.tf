module "sg"{
    source = "../../aws-sg-module-terraform"
    project = var.project
    env = var.env
    sg_name = "mongodb"
    vpc_id= local.vpc_id
}