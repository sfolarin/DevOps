/*
terraform {


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "state" {
  bucket = "tfstates-bucket-0051"

  tags = {
    Name        = "shola-bucket"
  }
}

#Creating a bucket versioning
resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "example" {
  name             = "tfstate-Dynamo"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
 

  attribute {
    name = "LockID"
    type = "S"
  }
}
/*
####################################################
resource "aws_instance" "web" {
  ami           = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  #availability_zone = us-east-1a

  tags = {
    Name = "Hello"
  }
 }
##############################################################
*/
*/
