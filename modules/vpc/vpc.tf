# --- VPC ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "${var.Project}-vpc" }
}

# --- Internet Gateway ---
# Required for Public Subnets to access the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.Project}-igw" }
}

# --- Subnets ---
# We define them as a map to allow for_each iteration
resource "aws_subnet" "subnets" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = "${var.Project}-${each.value.type}-subnet-${each.value.az}"
    Type = each.value.type
  }
}

# --- Elastic IP for NAT Gateway ---
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags   = { Name = "${var.Project}-nat-eip" }
}

# --- NAT Gateway ---
# Created in one of the public subnets
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  # We pick the first public subnet to host the NAT Gateway
  subnet_id  = [for s in aws_subnet.subnets : s.id if s.tags.Type == "public"][0]
  tags       = { Name = "${var.Project}-nat-gw" }
  depends_on = [aws_internet_gateway.igw]
}

# --- Route Table (Public) ---
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.whole_route
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.Project}-public-rt" }
}

# --- Route Table (Private) ---
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = var.whole_route
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = { Name = "${var.Project}-private-rt" }
}

# --- Route Table Associations ---
resource "aws_route_table_association" "public_assoc" {
  for_each       = { for k, v in aws_subnet.subnets : k => v if v.tags.Type == "public" }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = { for k, v in aws_subnet.subnets : k => v if v.tags.Type == "private" }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}