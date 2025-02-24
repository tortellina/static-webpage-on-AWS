#configuration of the application load balancer
#type of alb, subnet associations, security groups, listener and target group



resource "aws_lb" "webpage_lb" {
  name               = "webpagelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

