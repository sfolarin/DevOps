/*
terraform {
  backend "s3" {
    bucket         = "tfstates-bucket-0051"
    key            = "statefile/tf.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-Dynamo"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


####################################################
resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "web" {
  #for_each      = var.instances
  ami           = var.amis["ami"]
  instance_type = var.instances["instance01"]
  #instance_type = each.value
  key_name = aws_key_pair.dove-key.key_name
  #availability_zone = us-east-1a

  tags = {
    #Name = each.key
    Name = "myProject"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
       "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = "ubuntu"
    private_key = file("dovekey")
    host        = self.public_ip

  }
}
*/
