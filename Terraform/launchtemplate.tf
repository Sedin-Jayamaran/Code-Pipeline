resource "aws_launch_template" "jai-launch-template" {
  name = "jai-launch-template"

  # Root volume config
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  image_id = data.aws_ssm_parameter.ecs_ami.value

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"

  monitoring {
    enabled = true
  }

  key_name = "QQQQQQ"  

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ecs_sg.id]  
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "jai-launch-template"
    }
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=JAI-TERRA-CLUSTER >> /etc/ecs/ecs.config
EOF
  )
}
