terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.96.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "instance" {
  source = "./ec2"
}