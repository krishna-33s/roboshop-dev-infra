#mysql iam role
resource "aws_iam_role" "mysql" {
  name = local.mysql_role # Database-Roboshop-Dev-Mysql

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
    {
        Name = local.mysql_role
    },
    local.common_tags
  )
}

# create policy by copying the file of "mysql-policy.json" file
resource "aws_iam_policy" "policy" {
  name        = local.mysql_policy
  description = "A test policy"
  policy      = templatefile("mysql-policy.json", 
  { env=var.env })
}

# attach policy to the IAM Role
resource "aws_iam_policy_attachment" "mysql" {
  name = "mysql_policy_attachment"
  roles      = [aws_iam_role.mysql.name]
  policy_arn = aws_iam_policy.policy.arn
}

# instance profile 
resource "aws_iam_instance_profile" "mysql" {
  name = "mysql-${var.project}-${var.env}"
  role = aws_iam_role.mysql.name
}


#rabbitmq iam role
resource "aws_iam_role" "rabbitmq" {
  name = local.rabbitmq_role # Database-Roboshop-Dev-Rabbitmq

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
    {
        Name = local.rabbitmq_role
    },
    local.common_tags
  )
}

# create policy by copying the file of "rabbitmq-policy.json" file
resource "aws_iam_policy" "policy" {
  name        = local.rabbitmq_policy
  description = "A test policy"
  policy      = templatefile("rabbitmq-policy.json", 
  { env=var.env })
}

# attach policy to the IAM Role
resource "aws_iam_policy_attachment" "rabbitmq" {
  name = "rabbitmq_policy_attachment"
  roles      = [aws_iam_role.rabbitmq.name]
  policy_arn = aws_iam_policy.policy.arn
}

# instance profile 
resource "aws_iam_instance_profile" "rabbitmq" {
  name = "rabbitmq-${var.project}-${var.env}"
  role = aws_iam_role.rabbitmq.name
}