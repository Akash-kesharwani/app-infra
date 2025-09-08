variable "subnet-name" {}
variable "rg-name" {}
variable "vnet-name" {}
variable "address_prefixes" {
  type = list(string)
  default = ["10.0.1.0/24"]
} 