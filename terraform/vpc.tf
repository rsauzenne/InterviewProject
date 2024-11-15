resource "aws_vpc" "weather-app" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "weather-app" {
  vpc_id            = aws_vpc.weather-app.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_security_group" "weather-app" {
  vpc_id = aws_vpc.weather-app.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}