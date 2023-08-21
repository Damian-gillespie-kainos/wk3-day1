terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    tls = {                          # TLS for keys
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = var.REGION
}
