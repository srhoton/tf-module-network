data "aws_route53_zone" "client_vpn_zone" {
  name = "steverhoton.com"
  private_zone = false
}

data "aws_acm_certificate" "client_vpn_root" {
  domain = "client.vpn.steverhoton.com"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "server_vpn_root" {
  domain = "server.vpn.steverhoton.com"
  statuses = ["ISSUED"]
}

resource "aws_ec2_client_vpn_endpoint" "client_vpn_endpoint" {
  count = var.enable_vpn ? 1 : 0
  description = "Client Vpn Endpoint for ${var.env_name}"
  client_cidr_block = module.subnet_addrs.network_cidr_blocks["vpn-1"]
  split_tunnel = true
  server_certificate_arn = data.aws_acm_certificate.server_vpn_root.arn

  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.client_vpn_root.arn
  }
  
  connection_log_options {
    enabled = false
  }
}

resource "aws_security_group" "vpn_access" {
  count = var.enable_vpn ? 1 : 0
  vpc_id = aws_vpc.default_vpc.id
  name = "${var.env_name}-vpn-access"

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn_subnets" {

  count = var.enable_vpn ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id
  subnet_id = aws_subnet.default_subnets["private-3"].id
  security_groups = [aws_security_group.vpn_access[0].id]

  lifecycle {
    // The issue why we are ignoring changes is that on every change
    // terraform screws up most of the vpn assosciations
    // see: https://github.com/hashicorp/terraform-provider-aws/issues/14717
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  count = var.enable_vpn ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint[0].id
  target_network_cidr = aws_vpc.default_vpc.cidr_block
  authorize_all_groups = true
}
