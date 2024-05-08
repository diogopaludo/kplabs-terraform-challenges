provider "aws" {
  region = "sa-east-1"
}

terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
  required_version = "1.8.2"
}


resource "aws_eip" "kplabs_app_ip" {
    domain = "vpc"
}
