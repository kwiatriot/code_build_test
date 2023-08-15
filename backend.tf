terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kwiatriot"

    workspaces {
      name = "code_build_test"
    }
  }
}