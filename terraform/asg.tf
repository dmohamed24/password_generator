resource "aws_launch_template" "asg_template" {
  image_id               = "ami-00fefe800bd08f8da"
  instance_type          = "t2.micro"
  key_name               = "bastion_key_pair"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd

              sudo tee /var/www/html/index.html > /dev/null <<EOT
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <title>Welcome to My EC2 Site</title>
                  <style>
                      body { background-color: #f0f0f0; font-family: Arial, sans-serif; text-align: center; padding-top: 50px; }
                      h1 { color: #333; }
                      p { color: #666; }
                  </style>
              </head>
              <body>
                  <h1>Hello from EC2!</h1>
                  <p>Deployed with Terraform and Apache</p>
              </body>
              </html>
              EOT
              EOF
  )


  depends_on = [
    aws_security_group.ec2_sg
  ]

  tags = {
    Name = "asg_template"
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "ec2-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  target_group_arns         = [aws_lb_target_group.alb_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.asg_template.id
    version = "$Latest"
  }


  depends_on = [
    aws_subnet.public_subnet_a, aws_subnet.public_subnet_b, aws_lb_target_group.alb_tg
  ]
}

resource "aws_autoscaling_policy" "autoscaling_policy" {
  name                   = "autoscaling policy for asg"
  scaling_adjustment     = 1
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.id
}




# variable "docker_username" {}
# variable "github_sha" {}


# resource "aws_launch_template" "asg_template" {
#   image_id               = "ami-00fefe800bd08f8da"
#   instance_type          = "t2.micro"
#   key_name               = "bastion_key_pair"
#   vpc_security_group_ids = [aws_security_group.ec2_sg.id]
#   user_data = base64encode(<<-EOF
#         #!/bin/bash
#         sudo yum update -y
#         sudo yum install docker -y
#         sudo service docker start
#         sudo docker stop app || true
#         sudo docker rm app || true
#         sudo docker pull ${var.docker_username}/password-generator-app:TEST-${var.github_sha}
#       EOF
#   )