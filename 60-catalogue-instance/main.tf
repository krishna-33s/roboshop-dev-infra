#catalogue instance provisioning--->
resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet_id
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = merge(
    { Name = "catalogue-${var.project}-${var.env}" },
    local.common_tags
  )
}


resource "terraform_data" "catalogue_bootstrap" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline =[
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue dev"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [aws_instance.catalogue]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "catalogue-${var.project}-${var.env}"
  source_instance_id = "aws_instance.catalogue"
  depends_on = [aws_ec2_instance_state.catalogue]

  tags = merge(
    { Name = "catalogue-${var.project}-${var.env}" },
    local.common_tags
  )
}