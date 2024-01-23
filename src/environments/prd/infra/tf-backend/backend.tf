terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "deCort-tech"

    workspaces {
      name = "tf-backend"
    }
  }
}
