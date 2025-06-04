# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.default_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.default_vpc.cidr_block
}

# Subnet List Outputs (Legacy)
output "private_subnet_list" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.default_subnets["private-1"].id, aws_subnet.default_subnets["private-2"].id, aws_subnet.default_subnets["private-3"].id]
}

output "private_subnet_list_mwaa" {
  description = "List of private subnet IDs for MWAA (excludes private-3)"
  value       = [aws_subnet.default_subnets["private-1"].id, aws_subnet.default_subnets["private-2"].id]
}

output "public_subnet_list" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.default_subnets["public-1"].id, aws_subnet.default_subnets["public-2"].id, aws_subnet.default_subnets["public-3"].id]
}

# Individual Subnet Outputs
output "private_subnet_1_id" {
  description = "ID of private subnet 1 (us-east-1a)"
  value       = aws_subnet.default_subnets["private-1"].id
}

output "private_subnet_2_id" {
  description = "ID of private subnet 2 (us-east-1b)"
  value       = aws_subnet.default_subnets["private-2"].id
}

output "private_subnet_3_id" {
  description = "ID of private subnet 3 (us-east-1c)"
  value       = aws_subnet.default_subnets["private-3"].id
}

output "public_subnet_1_id" {
  description = "ID of public subnet 1 (us-east-1a)"
  value       = aws_subnet.default_subnets["public-1"].id
}

output "public_subnet_2_id" {
  description = "ID of public subnet 2 (us-east-1b)"
  value       = aws_subnet.default_subnets["public-2"].id
}

output "public_subnet_3_id" {
  description = "ID of public subnet 3 (us-east-1c)"
  value       = aws_subnet.default_subnets["public-3"].id
}

output "vpn_subnet_id" {
  description = "ID of VPN subnet (us-east-1c)"
  value       = aws_subnet.default_subnets["vpn-1"].id
}

# Subnet CIDR Blocks
output "private_subnet_cidrs" {
  description = "CIDR blocks of private subnets"
  value = {
    private-1 = aws_subnet.default_subnets["private-1"].cidr_block
    private-2 = aws_subnet.default_subnets["private-2"].cidr_block
    private-3 = aws_subnet.default_subnets["private-3"].cidr_block
  }
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of public subnets"
  value = {
    public-1 = aws_subnet.default_subnets["public-1"].cidr_block
    public-2 = aws_subnet.default_subnets["public-2"].cidr_block
    public-3 = aws_subnet.default_subnets["public-3"].cidr_block
  }
}

output "vpn_subnet_cidr" {
  description = "CIDR block of VPN subnet"
  value       = aws_subnet.default_subnets["vpn-1"].cidr_block
}

# Subnet Availability Zones
output "subnet_availability_zones" {
  description = "Map of subnet names to their availability zones"
  value = {
    for name, subnet in aws_subnet.default_subnets : name => subnet.availability_zone
  }
}

# Network Gateway Outputs
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.default_igw.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.default_nat[0].id : null
}

output "nat_gateway_public_ip" {
  description = "Public IP of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_eip.default_eip.public_ip : null
}

# Route Table Outputs
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.default_public_table.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.default_private_table.id
}

# Client VPN Outputs
output "client_vpn_endpoint_id" {
  description = "ID of the Client VPN Endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id : null
}

output "client_vpn_endpoint_dns_name" {
  description = "DNS name of the Client VPN Endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].dns_name : null
}

output "client_vpn_client_cidr_block" {
  description = "CIDR block assigned to VPN clients"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].client_cidr_block : null
}

output "client_vpn_security_group_id" {
  description = "ID of the Client VPN security group"
  value       = var.enable_vpn ? aws_security_group.vpn_access[0].id : null
}

output "client_vpn_status" {
  description = "Status of the Client VPN Endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].status : null
}
  