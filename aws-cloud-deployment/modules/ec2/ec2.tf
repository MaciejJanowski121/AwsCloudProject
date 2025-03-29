
# Launch Template für EC2-Instanz
resource "aws_launch_template" "ec2_template" {
  name_prefix   = "ec2-template"
  image_id      = "ami-0559679b06ebd7e58"  # Amazon Linux 2 mit SSM-Agent
  instance_type = "t2.micro"               # Free Tier

  iam_instance_profile {
    name = var.ec2_instance_profile  # IAM Instance Profile für EC2
  }

  network_interfaces {
    associate_public_ip_address = false  # Kein öffentliches IP
    security_groups             = [var.ec2_sg_id, var.ssm_sg_id]  # Sicherheitsgruppen (EC2 + SSM)
  }

  # Startkonfiguration via User Data (Bash)
  user_data = base64encode(<<EOF
#!/bin/bash

set -e  # Bei Fehler abbrechen

# Installation SSM-Agent
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Installation Java 17 (Amazon Corretto)
sudo yum install -y java-17-amazon-corretto-devel

# Installation CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# CloudWatch Agent Konfiguration
cat <<CWAGENTCONFIG | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/aws/ec2/springboot-backend",
            "log_stream_name": "{instance_id}",
            "timezone": "UTC"
          }
        ]
      }
    }
  }
}
CWAGENTCONFIG

# CloudWatch Agent starten
sudo amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

# Absicherung: Agent beim Start automatisch starten
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent

# Spring Boot JAR von S3 herunterladen
aws s3 cp s3://spring-bucket-maciej123/blog-0.0.1-SNAPSHOT.jar /home/ec2-user/app.jar --endpoint-url=https://s3.eu-central-1.amazonaws.com

# Anwendung starten
nohup java -jar /home/ec2-user/app.jar > /home/ec2-user/app.log 2>&1 &

EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "SpringBoot-Backend"
    }
  }
}