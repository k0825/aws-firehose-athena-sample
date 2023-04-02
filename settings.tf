terraform {
  required_version = "~> 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
  }

  backend "s3" {
    bucket = "ikari-tfstate"
    region = "ap-northeast-1"
    key    = "firehose-athena-sample/terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
