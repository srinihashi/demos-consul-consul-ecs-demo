terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2"
    }
  }
}

provider "aws" {
  region = var.vpc_region
}
