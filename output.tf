# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.default_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.default_vpc.cidr_block
}

# Subnet Outputs
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = [
    for key, subnet in aws_subnet.default_subnets : subnet.id
    if startswith(key, "private-")
  ]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = [
    for key, subnet in aws_subnet.default_subnets : subnet.id
    if startswith(key, "public-")
  ]
}

output "private_subnet_list" {
  description = "List of private subnet IDs (legacy output for backwards compatibility)"
  value = [
    aws_subnet.default_subnets["private-1"].id,
    aws_subnet.default_subnets["private-2"].id,
    aws_subnet.default_subnets["private-3"].id
  ]
}

output "private_subnet_list_mwaa" {
  description = "List of private subnet IDs for MWAA (first two private subnets)"
  value = [
    aws_subnet.default_subnets["private-1"].id,
    aws_subnet.default_subnets["private-2"].id
  ]
}

output "public_subnet_list" {
  description = "List of public subnet IDs (legacy output for backwards compatibility)"
  value = [
    aws_subnet.default_subnets["public-1"].id,
    aws_subnet.default_subnets["public-2"].id,
    aws_subnet.default_subnets["public-3"].id
  ]
}

output "subnet_details" {
  description = "Detailed information about all subnets"
  value = {
    for key, subnet in aws_subnet.default_subnets : key => {
      id                = subnet.id
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
      vpc_id           = subnet.vpc_id
    }
  }
}

# Client VPN Outputs
output "client_vpn_endpoint_id" {
  description = "ID of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id : null
}

output "client_vpn_endpoint_arn" {
  description = "ARN of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].arn : null
}

output "client_vpn_dns_name" {
  description = "DNS name of the Client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].dns_name : null
}

output "client_vpn_cidr_block" {
  description = "CIDR block assigned to the Client VPN"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].client_cidr_block : null
}

output "vpn_security_group_id" {
  description = "ID of the VPN access security group"
  value       = var.enable_vpn ? aws_security_group.vpn_access[0].id : null
}

# Network Infrastructure Outputs
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.default_igw.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? aws_nat_gateway.default_nat[0].id : null
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.default_public_table.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.default_private_table.id
}
  