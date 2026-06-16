terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.43.0"
    }
  }
  backend "s3" {
    bucket = "krishna-dev-88s"
    key    = "openvpn-dev"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}