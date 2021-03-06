terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
  backend "s3" {
    bucket = "tf-backend-shewitt"
    key    = "terraform.tfstate"
    region = "us-east-1"
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

resource "aws_s3_bucket" "static" {
  bucket = "bucket-by-terraform-static"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "bucket-by-terraform-static"
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
  acl          = "public-read"
}
