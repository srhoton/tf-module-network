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
  description = "Client Vpn Endpoint for ${var.env_name}"
  client_cidr_block = module.subnet_addrs.network_cidr_blocks["private-1"]
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
