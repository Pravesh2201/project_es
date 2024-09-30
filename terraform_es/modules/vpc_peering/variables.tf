variable "vpc_id" {
    description = "This ID of the VPC you want to create a peering connecting from"
    type = string
  
}

variable "peer_vpc_id" {
    description = "The ID of the VPC you want to peer with "
    type = string
  
}

variable "peering_name" {
    description = "The name of the VPC peering connection"
    type = string
  
}