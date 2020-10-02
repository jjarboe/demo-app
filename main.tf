provider "aws" {
  region = "us-east-1"
}

variable "env" {
  default = "stage"
}
