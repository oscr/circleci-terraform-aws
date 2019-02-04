variable "table-name" {
  default = "eatit-table"
}

variable "region" {
  default = "eu-central-1"
}

variable "environment" {}

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
  name           = "${var.table-name}-${var.environment}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "EventId"

  attribute {
    name = "EventId"
    type = "S"
  }

  tags {
    Project = "eatit"
  }
}
