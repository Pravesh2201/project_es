output "vpc_peering_connection_id" {
    description = "ID of the VPC peering connection"
    value = aws_vpc_peering_connection.peer.id
  
}

output "vpc_peering_connection_accepter_status" {
    description = "Status of the VPC peering connection"
    value = aws_vpc_peering_connection_accepter.peer_accepter.accept_status
  
}