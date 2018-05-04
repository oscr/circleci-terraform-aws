provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "circle-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_vpc" "minimal" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "minimal"
  }
}