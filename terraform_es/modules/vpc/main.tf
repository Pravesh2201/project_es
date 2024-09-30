resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main Internet Gateway"
  }
}

resource "aws_route" "peer_route" {
  count                   = var.peer_cidr_block != "" ? 1 : 0  # Only create if peer CIDR is provided
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = var.peer_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}
