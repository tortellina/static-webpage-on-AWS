#configuration of the auto scaling group
#capacity, minimum and maximum, launch configuration (istances), health checks, policies

resource "aws_lb_target_group" "website_tg" {
  name     = "website-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 10
    matcher             = "200-399"
  }

  slow_start = 30

  tags = {
    Name = "MyAppTargetGroup"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.webpage_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.website_tg.arn
  }
}




resource "aws_iam_role" "minimal_role" {
  name = "EC2MinimalRole"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = aws_iam_role.minimal_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "minimal_profile" {
  name = "EC2MinimalProfile"
  role = aws_iam_role.minimal_role.name
}



resource "aws_launch_template" "EC2_instance_website" {
  name = "web-server-template"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  image_id      = var.instance_ami
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web Server"
    }
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>this is the company's webpage</h1>" > /var/www/html/index.html
              EOF
  )
}


resource "aws_autoscaling_policy" "aws_autoscaling_policy" {
  name                   = "autoscaling policy website"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name

  depends_on = [aws_autoscaling_group.asg]
}

resource "aws_autoscaling_group" "asg" {
  name                      = "webpage-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = false


  vpc_zone_identifier = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  target_group_arns = [aws_lb_target_group.website_tg.arn]

  launch_template {
    id      = aws_launch_template.EC2_instance_website.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_policy" "replace_unhealthy" {
  name                   = "replace-unhealthy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name

}

