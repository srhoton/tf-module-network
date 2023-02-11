module "subnet_addrs" { 
  source = "hashicorp/subnets/cidr"

  #base_cidr_block = "192.168.0.0/16"
  base_cidr_block = var.base_cidr_block


  networks = [
    {
        name = "private-1"
        new_bits = 4
    },
    {
        name = "private-2"
        new_bits = 4
    },
    {
        name = "private-3"
        new_bits = 4
    },
    {
        name = "public-1"
        new_bits = 4
    },
    {
        name = "public-2"
        new_bits = 4
    },
    {
        name = "public-3"
        new_bits = 4
    }
  ]
}

resource "aws_vpc" "default_vpc" { 
  cidr_block = module.subnet_addrs.base_cidr_block
  tags = {
    Name = "default_vpc"
  }
}

resource "aws_subnet" "default_subnets" {
  for_each = module.subnet_addrs.network_cidr_blocks

  vpc_id = aws_vpc.default_vpc.id
  availability_zone = lookup(var.az_mapping, each.key)
  cidr_block = each.value
  tags = {
    Name = each.key
  }
}

# Public Config
resource "aws_internet_gateway" "default_igw" {
  vpc_id = aws_vpc.default_vpc.id
  tags = {
    Name = "default_igw"
  }
}

resource "aws_route_table" "default_public_table" {
  vpc_id = aws_vpc.default_vpc.id
  tags = {
    Name = "default_public_table"
  }
}

resource "aws_route" "public_default_route" { 
  route_table_id = aws_route_table.default_public_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default_igw.id
}

resource "aws_route_table_association" "public_default_route_1" {
  subnet_id = aws_subnet.default_subnets["public-1"].id
  route_table_id = aws_route_table.default_public_table.id
}

resource "aws_route_table_association" "public_default_route_2" {
  subnet_id = aws_subnet.default_subnets["public-2"].id
  route_table_id = aws_route_table.default_public_table.id
}

resource "aws_route_table_association" "public_default_route_3" {
  subnet_id = aws_subnet.default_subnets["public-2"].id
  route_table_id = aws_route_table.default_public_table.id
}

#Private Config
resource "aws_eip" "default_eip" {
  vpc = true
  tags = {
    Name = "default_eip"
  }
}
  
resource "aws_nat_gateway" "default_nat" {
  allocation_id = aws_eip.default_eip.id
  subnet_id = aws_subnet.default_subnets["public-1"].id
  tags = {
    Name = "default_nat"
  }
}

resource "aws_route" "private_default_route" { 
  route_table_id = aws_route_table.default_private_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.default_nat.id
}

resource "aws_route_table" "default_private_table" {
  vpc_id = aws_vpc.default_vpc.id
  tags = {
    Name = "default_private_table"
  }
}

resource "aws_route_table_association" "private_default_route_1" {
  subnet_id = aws_subnet.default_subnets["private-1"].id
  route_table_id = aws_route_table.default_private_table.id
}

resource "aws_route_table_association" "private_default_route_2" {
  subnet_id = aws_subnet.default_subnets["private-2"].id
  route_table_id = aws_route_table.default_private_table.id
}

resource "aws_route_table_association" "private_default_route_3" {
  subnet_id = aws_subnet.default_subnets["private-3"].id
  route_table_id = aws_route_table.default_private_table.id
}
