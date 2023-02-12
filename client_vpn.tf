data "aws_route53_zone" "client_vpn_zone" {
  name = "steverhoton.com"
  private_zone = false
}


resource "aws_acm_certificate" "client_vpn_certificate" {
  domain_name = "${aws_vpc.default_vpc.id}-vpn.steverhoton.com"
  validation_method = "DNS"
}

resource "aws_route53_record" "client_vpn_record" {
  for_each = {
    for dvo in aws_acm_certificate.client_vpn_certificate.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = data.aws_route53_zone.client_vpn_zone.id
}


resource "aws_acm_certificate_validation" "client_vpn_certificate_validation" {
  certificate_arn = aws_acm_certificate.client_vpn_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.client_vpn_record : record.fqdn]
}
