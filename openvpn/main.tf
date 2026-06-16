resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = "t3.small"
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [local.openvpn_sg_id]
  user_data=file("bastion.sh")


  tags = merge(
    { Name = "openvpn-${var.project}-${var.env}" },
    local.common_tags
  )
}