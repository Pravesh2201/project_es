variable "key_name" {
  description = "The AWS key pair name to access the EC2 instance"
  type        = string
  default = "AWS"
}

variable "associate_public_ip_address" {
  type = bool
  
}
