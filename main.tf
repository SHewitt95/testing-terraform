terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}

provider "aws" {
  region      = "us-east-1"
  max_retries = 1
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucket-by-terraform"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}