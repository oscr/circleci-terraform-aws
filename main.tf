variable "table-name" {
  default = "eatit-table"
}

variable "region" {
  default = "eu-central-1"
}

variable "db_password" {}

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "circle-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

resource "aws_dynamodb_table" "eatit-table" {
  name           = "${var.table-name}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "EventId"

  attribute {
    name = "EventId"
    type = "S"
  }

  tags {
    Project = "eatit"
  }
}

resource "aws_vpc" "minimal" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "${var.db_password}"
  }
}