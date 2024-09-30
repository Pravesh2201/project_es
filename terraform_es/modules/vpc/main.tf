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

# Use existing private route table

resource "aws_route" "peer_route" {
  count                   = var.peer_cidr_block != "" ? 1 : 0  # Only create if peer CIDR is provided
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = var.peer_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}

# Other resources, including the existing route table associations
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}
