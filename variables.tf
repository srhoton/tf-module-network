variable "base_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "az_mapping" {
  description = "AZ names to their zones"
  default = {
    "private-1" = "us-west-2a"
    "private-2" = "us-west-2b"
    "private-3" = "us-west-2c"
    "public-1" = "us-west-2a"
    "public-2" = "us-west-2b"
    "public-3" = "us-west-2c"

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