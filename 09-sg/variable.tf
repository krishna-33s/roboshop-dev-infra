variable "project"{
    default = "roboshop"
}

variable "env"{
    default = "dev"
}

variable "sg_names"{
    type = list
    default= [
        #database
        "Mongodb",
        "Redis",
        "Mysql",
        "Rabbitmq",

        #backend
        "Catalogue",
        "User",
        "Cart",
        "Shipping",
        "Payment",

        #backend ALB
        "Backend_ALB",

        #frontend
        "Frontend",

        #frontend ALB
        "Frontend_ALB",

        #bastion
        "Bastion"
    ]
}