variable "amis" {
  type = map(string)
  default = {
    #"ami"    = "ami-066784287e358dad1"
    "ami" = "ami-0a0e5d9c7acc336f1"
    key_name = "terra"
  }
}

variable "instances" {
  type = map(string)
  default = {
    "instance01" = "t2.micro"
    #"instance02" = "t2.micro"

  }

}

variable "myinstant" {
type = string
default = "t2.micro"
}