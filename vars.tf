variable "REGION" {
  default = "eu-west-1"
}

variable "AMI" {
  default = "ami-01dd271720c1ba44f"
}

variable "ZONE" {
  default = "eu-west-1a"
}

variable "trusted_ips" {
  type        = list(string)
  description = "List of trusted Kainos IP addresses"
}