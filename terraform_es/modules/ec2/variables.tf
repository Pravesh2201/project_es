variable "ami_id" {
  type    = string
}

variable "key_name" {
  type    = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_sg_id" {
  description = "The security group ID for the public instance"
  type        = string
}

variable "private_sg_id" {
  description = "The security group ID for the private instance"
  type        = string
}

variable "public_instance" {
  type = string
  default = "bastion_instance"
  
}

variable "private_instance" {
  type = string
  default = "elasticsearch"
  
}

