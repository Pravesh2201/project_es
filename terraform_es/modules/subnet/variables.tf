variable "vpc_id" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "az" {
  type = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
  
}
