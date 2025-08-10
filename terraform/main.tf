terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}


terraform {
  backend "s3" {
    bucket         = "dahir-98-tf-state-bucket" # your bucket name
    key            = "terraform/state.tfstate"  # path in bucket for state file
    region         = "eu-west-2"                # your bucket region
    encrypt        = true
    dynamodb_table = "terraform-locks" # optional locking
  }
}