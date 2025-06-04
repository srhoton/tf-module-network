# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.default_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.default_vpc.cidr_block
}

# All Subnet Outputs
output "subnet_ids" {
  description = "Map of all subnet names to their IDs"
  value       = { for name, subnet in aws_subnet.default_subnets : name => subnet.id }
}

output "subnet_cidr_blocks" {
  description = "Map of all subnet names to their CIDR blocks"
  value       = { for name, subnet in aws_subnet.default_subnets : name => subnet.cidr_block }
}

# Private Subnet Outputs
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [
    for name, subnet in aws_subnet.default_subnets : subnet.id
    if startswith(name, "private-")
  ]
}

output "private_subnet_list" {
  description = "List of all private subnet IDs (legacy compatibility)"
  value = [
    aws_subnet.default_subnets["private-1"].id,
    aws_subnet.default_subnets["private-2"].id,
    aws_subnet.default_subnets["private-3"].id
  ]
}

output "private_subnet_list_mwaa" {
  description = "List of private subnet IDs for MWAA (requires 2 subnets)"
  value = [
    aws_subnet.default_subnets["private-1"].id,
    aws_subnet.default_subnets["private-2"].id
  ]
}

output "private_subnet_1_id" {
  description = "ID of private subnet 1"
  value       = aws_subnet.default_subnets["private-1"].id
}

output "private_subnet_2_id" {
  description = "ID of private subnet 2"
  value       = aws_subnet.default_subnets["private-2"].id
}

output "private_subnet_3_id" {
  description = "ID of private subnet 3"
  value       = aws_subnet.default_subnets["private-3"].id
}

# Public Subnet Outputs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [
    for name, subnet in aws_subnet.default_subnets : subnet.id
    if startswith(name, "public-")
  ]
}

output "public_subnet_list" {
  description = "List of all public subnet IDs (legacy compatibility)"
  value = [
    aws_subnet.default_subnets["public-1"].id,
    aws_subnet.default_subnets["public-2"].id,
    aws_subnet.default_subnets["public-3"].id
  ]
}

output "public_subnet_1_id" {
  description = "ID of public subnet 1"
  value       = aws_subnet.default_subnets["public-1"].id
}

output "public_subnet_2_id" {
  description = "ID of public subnet 2"
  value       = aws_subnet.default_subnets["public-2"].id
}

output "public_subnet_3_id" {
  description = "ID of public subnet 3"
  value       = aws_subnet.default_subnets["public-3"].id
}

# VPN Subnet Outputs
output "vpn_subnet_id" {
  description = "ID of the VPN subnet"
  value       = aws_subnet.default_subnets["vpn-1"].id
}

output "vpn_subnet_cidr" {
  description = "CIDR block of the VPN subnet"
  value       = aws_subnet.default_subnets["vpn-1"].cidr_block
}

# Client VPN Outputs
output "client_vpn_endpoint_id" {
  description = "ID of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id : null
}

output "client_vpn_endpoint_dns_name" {
  description = "DNS name of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].dns_name : null
}

output "client_vpn_endpoint_arn" {
  description = "ARN of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].arn : null
}

output "client_vpn_cidr_block" {
  description = "CIDR block assigned to Client VPN clients"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].client_cidr_block : null
}

output "vpn_security_group_id" {
  description = "ID of the VPN security group"
  value       = var.enable_vpn ? aws_security_group.vpn_access[0].id : null
}

# Networking Component Outputs
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
  value       = var.enable_nat_gateway ? aws_nat_gateway.default_nat[0].public_ip : null
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.default_public_table.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.default_private_table.id
}
  