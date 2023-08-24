output "RDS-endpoint" {
  description = "End point of database"
  value       = aws_db_instance.kpa-db-dg.address
}

output "RDS_port" {
  description = "The port of the DB"
  value       = aws_db_instance.kpa-db-dg.port
}

output "E-IP1" {
  description = "Elastic IP1"
  value       = aws_eip.kpa-eip1-dg.public_ip
}

output "E-IP2" {
  description = "Elastic IP2"
  value       = aws_eip.kpa-eip2-dg.public_ip
}