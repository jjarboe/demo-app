resource "aws_security_group" "project_sg" {
  name        = "shared_project_sg"
  description = "shared project security group"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["<cidr>"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "resource_sg" {
  name        = "vm_sg"
  description = "recommended sg for vms"
  vpc_id      = aws_vpc.main_vpc.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["<cidr>", "<cidr>"]
  }
}
