locals {
    ami_id = data.aws_ami.redhat.id
    database_subnet_id = split(",",data.aws_ssm_parameter.database_subnet_id.value)[0]
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    mysql_role = join("-",
        [for i in ["database", "${var.project}", "${var.env}", "mysql"]: title(i)])
    mysql_policy = join("",
        [for i in ["database", "${var.project}", "${var.env}", "mysql"]: title(i)])
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
    rabbitmq_role = join("-",
        [for i in ["database", "${var.project}", "${var.env}", "rabbitmq"]: title(i)])
    rabbitmq_policy = join("",
        [for i in ["database", "${var.project}", "${var.env}", "rabbitmq"]: title(i)])

    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}