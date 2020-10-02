resource "aws_db_instance" "project_db" {
  allocated_storage                   = 20
  storage_type                        = "gp2"
  engine                              = "mysql"
  engine_version                      = "5.7"
  instance_class                      = "db.m5.xlarge"
  name                                = "mydb"
  backup_retention_period             = 30
  iam_database_authentication_enabled = true
}

resource "aws_db_instance" "project_db_reports" {
  allocated_storage                   = 20
  storage_type                        = "gp2"
  engine                              = "mysql"
  engine_version                      = "5.7"
  instance_class                      = "db.m5.xlarge"
  name                                = "mydb"
  backup_retention_period             = 90
  iam_database_authentication_enabled = true
}
