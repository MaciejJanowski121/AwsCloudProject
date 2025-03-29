# Öffentliche Subnetze (z.B. für ALB oder Internetzugang)
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = element(["eu-central-1a", "eu-central-1b"], count.index) # Verteilung auf AZs

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Private Subnetze (z.B. für EC2, RDS etc.)
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(["eu-central-1a", "eu-central-1b"], count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}