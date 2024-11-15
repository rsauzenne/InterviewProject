provider "aws" {
  region = "us-west-2"
}

resource "aws_ecs_cluster" "weather-app" {
  name = "weather-app"
}

resource "aws_ecs_task_definition" "weather-app" {
  family                   = "weather-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "weather-app"
      image     = "123456789012.dkr.ecr.us-west-2.amazonaws.com/weather-app:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "weather-app" {
  name            = "weather-app"
  cluster         = aws_ecs_cluster.weather-app.id
  task_definition = aws_ecs_task_definition.weather-app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-12345678"]
    security_groups = ["sg-12345678"]
  }
}