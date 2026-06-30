output "vpc_id_value" {
  description = "This is a value of VPC Id"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "This variable give the  list of names for all created subnets"
  # This iterates over the map of resources and grabs the "Name" tag for each one
  #value       = [for s in aws_subnet.subnets : s.tags["Name"]]
  value = [for s in aws_subnet.subnets : s.id if s.tags["Type"] == "private"]
}