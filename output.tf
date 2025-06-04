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
output "subnets" {
  description = "Map of all subnets with their details"
  value = {
    for k, v in aws_subnet.default_subnets : k => {
      id                = v.id
      cidr_block        = v.cidr_block
      availability_zone = v.availability_zone
      arn              = v.arn
    }
  }
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for k, v in aws_subnet.default_subnets : v.id if startswith(k, "private")]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for k, v in aws_subnet.default_subnets : v.id if startswith(k, "public")]
}

output "vpn_subnet_ids" {
  description = "List of VPN subnet IDs"
  value       = [for k, v in aws_subnet.default_subnets : v.id if startswith(k, "vpn")]
}

# Legacy outputs for backward compatibility
output "private_subnet_list" {
  description = "Legacy output - use private_subnet_ids instead"
  value       = [for k, v in aws_subnet.default_subnets : v.id if startswith(k, "private")]
}

output "private_subnet_list_mwaa" {
  description = "Legacy output - first two private subnets for MWAA"
  value       = slice([for k, v in aws_subnet.default_subnets : v.id if startswith(k, "private")], 0, 2)
}

output "public_subnet_list" {
  description = "Legacy output - use public_subnet_ids instead"
  value       = [for k, v in aws_subnet.default_subnets : v.id if startswith(k, "public")]
}

# Network Infrastructure Outputs
output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.default_igw.id
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
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

# Client VPN Outputs
output "client_vpn_endpoint_id" {
  description = "ID of the client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id : null
}

output "client_vpn_endpoint_arn" {
  description = "ARN of the client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].arn : null
}

output "client_vpn_endpoint_dns_name" {
  description = "DNS name of the client VPN endpoint"
  value       = var.enable_vpn ? aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].dns_name : null
}

output "client_vpn_security_group_id" {
  description = "ID of the VPN security group"
  value       = var.enable_vpn ? aws_security_group.vpn_access[0].id : null
}

output "client_vpn_network_association_id" {
  description = "ID of the VPN network association"
  value       = var.enable_vpn ? aws_ec2_client_vpn_network_association.vpn_subnets[0].id : null
}
  