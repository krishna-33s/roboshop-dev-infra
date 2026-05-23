variable "project"{
    default = "roboshop"
}

variable "env"{
    default = "dev"
}

variable "sg_names"{
    [
        "Mongodb",
        "Redis",
        "Mysql",
        "Rabbitmq",
        "Catalogue",
        "User",
        "Cart",
        "Shipping"
        "Payment",
        "Backend_ALB",
        "Frontend",
        "Frontend_ALB"
    ]
}