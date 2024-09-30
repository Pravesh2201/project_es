variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_peering_connection_id" {
  description = "The ID of the VPC peering connection"
  type        = string
  default     = ""
}

variable "peer_cidr_block" {
  description = "The CIDR block of the peered VPC"
  type        = string
  default     = ""
}
