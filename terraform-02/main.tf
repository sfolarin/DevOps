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
/*
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

resource "aws_vpc" "main-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "main-pub1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "main-pub1"
  }
}

resource "aws_subnet" "main-pub2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "main-pub2"
  }
}

resource "aws_subnet" "main-pub3" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "main-pub3"
  }
}


resource "aws_subnet" "main-priv1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "main-priv1"
  }
}


resource "aws_subnet" "main-priv2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "main-priv2"
  }
}


resource "aws_subnet" "main-priv3" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "main-priv3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "main-pub1a" {
  subnet_id      = aws_subnet.main-pub1.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_route_table_association" "main-pub1b" {
  subnet_id      = aws_subnet.main-pub2.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_route_table_association" "main-pub1c" {
  subnet_id      = aws_subnet.main-pub3.id
  route_table_id = aws_route_table.route-table.id
}