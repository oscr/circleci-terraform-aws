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

variable "table-name" {
  default = "eatit-table"
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