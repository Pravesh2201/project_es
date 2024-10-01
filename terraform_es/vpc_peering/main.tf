# VPC Peering connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true
}

# Add route to the existing route table in the peer VPC
resource "aws_route" "peer_existing_route_table" {
  route_table_id         = var.existing_route_table_id  # The existing route table
  destination_cidr_block = var.vpc_cidr_block           # CIDR of the new VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Routes for VPC Peering in the new VPC
resource "aws_route" "peer_public_route" {
  route_table_id         = var.public_route_table_id
  destination_cidr_block = var.peer_vpc_cidr_block      # CIDR of the existing VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "peer_private_route" {
  route_table_id         = var.private_route_table_id
  destination_cidr_block = var.peer_vpc_cidr_block      # CIDR of the existing VPC
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
