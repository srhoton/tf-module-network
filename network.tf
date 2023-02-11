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
  route_table_id = aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.default_igw.id
}

resource "aws_route_table_association" "public_default_route" {
  subnet_id = module.subnet_addrs.aws_subnet.default_subnets["public-3"]
  route_table_id = aws_vpc.default_vpc.main_route_table_id
}
