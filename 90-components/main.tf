module "module" {
    for_each = var.module
    source = "git::https://github.com/krishna-33s/terraform-components-roboshop.git?ref=main" 
    module = each.key
    priority = each.priority.value
}