variable "key_name" {
  description = "The AWS key pair name to access the EC2 instance"
  type        = string
  default = "AWS"
}

variable "associate_public_ip_address" {
  type = bool
  default = true
  
}
variable "peer_cidr_block" {
  description = "The CIDR block of the peered VPC"
  type = string
  default = "10.0.2.0/24"
  
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type = string
  default     = "10.0.1.0/24"  # Set a default value here
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"  # Set a default value here
}
