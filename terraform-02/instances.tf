####################################################

resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "web" {
  #for_each      = var.instances
  ami           = var.amis["ami"]
  instance_type = var.instances["instance01"]
  subnet_id     = aws_subnet.main-pub1.id
  #instance_type = each.value
  key_name = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.sec_grp.id]
  associate_public_ip_address = true  # Ensure public IP is assigned

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
