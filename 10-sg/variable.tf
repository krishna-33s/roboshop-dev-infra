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
        "mongodb",
        "redis",
        "mysql",
        "rabbitmq",

        #backend
        "catalogue",
        "user",
        "cart",
        "shipping",
        "payment",

        #backend ALB
        "backend_ALB",

        #frontend
        "frontend",

        #frontend ALB
        "frontend_ALB",

        #bastion
        "bastion",

        #vpn
        "openvpn"
    ]
}