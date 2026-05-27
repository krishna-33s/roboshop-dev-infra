resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [local.bastion_sg_id]
  iam_instance_profile = aws_iam_instance_profile.bastiondev.name
  user_data=file("bastion.sh")

  root_block_device {
  
    volume_size = 50
    volume_type = "gp3"
    
    tags = merge(
    { Name = "bastion-${var.project}-${var.env}" },
    local.common_tags
  )

  }

  tags = merge(
    { Name = "bastion-${var.project}-${var.env}" },
    local.common_tags
  )
}


# Create IAM Role
resource "aws_iam_role" "BastionDev" {
  name = "BastionDev"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    { Name = "bastion-${var.project}-${var.env}" },
    local.common_tags
  )
}


# Attach Policy
resource "aws_iam_role_policy_attachment" "Bastion" {
  role       = aws_iam_role.BastionDev.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Instance Profile
resource "aws_iam_instance_profile" "bastiondev" {
  name = "bastion-${var.project}-${var.env}"
  role = aws_iam_role.BastionDev.name
}