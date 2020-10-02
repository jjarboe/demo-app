resource "aws_instance" "shared-vm" {
  ami           = "ami-id-00123"
  instance_type = "t2.micro"
}
