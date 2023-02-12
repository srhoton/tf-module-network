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

variable "key_name" {
  description = "value of the key_name to use for the bastion instance"
  default = "b2c"
}

variable "env_name" {
  description = "The environment name"
  default = "srhoton-dev"
}
