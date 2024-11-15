output "ecs_cluster_id" {
  value = aws_ecs_cluster.weather-app.id
}

output "ecs_service_name" {
  value = aws_ecs_service.weather-app.name
}