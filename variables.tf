variable "base_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "az_mapping" {
  description = "AZ names to their zones"
  default = {
    "private-1" = "us-east-1a"
    "private-2" = "us-east-1b"
    "private-3" = "us-east-1c"
    "vpn-1" = "us-east-1c"
    "public-1" = "us-east-1a"
    "public-2" = "us-east-1b"
    "public-3" = "us-east-1c"

  }
}

variable "public_ip_mapping" {
  description = "AZ names to their public ip setup"
  default = {
    "private-1" = false
    "private-2" = false
    "private-3" = false
    "vpn-1" = false
    "public-1" = true
    "public-2" = true
    "public-3" = true

  }
}
variable "key_name" {
  description = "value of the key_name to use for the bastion instance"
  default = "b2c"
}

variable "env_name" {
  description = "The environment name"
  default = "srhoton-dev"
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  default = true
}
  
variable "enable_vpn" {
  description = "Enable VPN Gateway"
  default = false
}
  
