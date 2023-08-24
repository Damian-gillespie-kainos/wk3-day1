### CREATING THE LOAD BALANCER

resource "aws_lb" "kpa-alb-dg" {
  name                       = "kpa-alb-dg"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.kpa-secgrp-dg.id]
  subnets                    = [aws_subnet.kpa-pub-sub1-dg.id, aws_subnet.kpa-pub-sub2-dg.id] # Should always be in the PUBLIC subnet and of 2 different zones
  enable_deletion_protection = false

  tags = {
    Name = "kpa-alb-dg"
  }
}

### CREATE THE TARGET GROUP

resource "aws_lb_target_group" "kpa-alb-target-group-dg" {
  name        = "kpa-alb-target-group-dg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.kpa-vpc-dg.id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

## CREATE A LISTENER

resource "aws_lb_listener" "kpa-lb-listener-dg" {
  load_balancer_arn = aws_lb.kpa-alb-dg.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kpa-alb-target-group-dg.arn

  }
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.kpa-alb-target-group-dg.arn
  target_id        = aws_instance.kpa-instance1-dg.private_ip
  port             = 80
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.kpa-alb-target-group-dg.arn
  target_id        = aws_instance.kpa-instance2-dg.private_ip
  port             = 80
}