output "private_subnet_list" {
  value = [aws_subnet.default_subnets["private-1"].id, aws_subnet.default_subnets["private-2"].id, aws_subnet.default_subnets["private-3"].id]
}

output "private_subnet_list_mwaa" {
  value = [aws_subnet.default_subnets["private-1"].id, aws_subnet.default_subnets["private-2"].id]
}

output "public_subnet_list" {
  value = [aws_subnet.default_subnets["public-1"].id, aws_subnet.default_subnets["public-2"].id, aws_subnet.default_subnets["public-3"].id]
}

output "vpc_id" {
  value = aws_vpc.default_vpc.id 
}
  