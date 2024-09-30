resource "aws_vpc_peering_connection" "peer" {
    peer_vpc_id = var.peer_vpc_id
    vpc_id = var.vpc_id
    # peer_region = var.peer_region
    auto_accept = true

    tags = {
      name = var.peering_name
    }
  
}

resource "aws_vpc_peering_connection_accepter" "peer_accepter" {
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    auto_accept = true
  
}