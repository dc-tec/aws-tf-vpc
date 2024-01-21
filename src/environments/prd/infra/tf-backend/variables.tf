variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default = {
    environment = "Dev"
    managedBy   = "Terraform"
  }
}