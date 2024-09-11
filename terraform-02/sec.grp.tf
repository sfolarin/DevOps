resource "aws_security_group" "sec_grp" {
  name        = "sec-grp-vpc"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main-vpc.id
  tags = {
    Name = "sec-grp-vpc"
  }
    ingress {
    description = "SSH access from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Change this to a more restrictive range in production
  }
  
  // Ensure outbound rules allow internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

# resource "aws_vpc_security_group_ingress_rule" "ingress-sec-grp" {
#   security_group_id = aws_security_group.sec_grp.id

#   cidr_ipv4   = "10.0.0.0/8"
#   from_port   = 22
#   ip_protocol = "tcp"
#   to_port     = 22
# }

resource "aws_vpc_security_group_ingress_rule" "ingress-sec-grp" {
  security_group_id = aws_security_group.sec_grp.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "egress-sec-grp" {
  security_group_id = aws_security_group.sec_grp.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}