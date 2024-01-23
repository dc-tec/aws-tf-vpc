terraform {
  backend "s3" {
    bucket = "s3-tf-state-bucket-eu-west-1"
    key    = "dev/infra/vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
