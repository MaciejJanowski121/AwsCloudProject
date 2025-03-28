resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = var.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = var.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}