terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }

  backend "remote" {
    organization = "Basic_Infrastructure"

    workspaces {
      name = "AWS-Basic-Infrastructure"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-lab"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = {
    Environment = var.environment
    Managed_by  = "Terraform"
  }
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}