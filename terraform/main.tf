resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and HTTP access for Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (you can restrict this to your IP)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Jenkins Web UI
  }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # APP Web UI
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

# Jenkins Master EC2 Instance using pre-installed Jenkins AMI
resource "aws_instance" "jenkins_master" {
  ami           = "ami-02aa54e145c19cdda"  # Pre-installed Jenkins AMI
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.jenkins_sg.name]

  # Script to generate SSH key and start Jenkins
  user_data = <<-EOF
              #!/bin/bash
              # Ensure Jenkins is running (should already be installed)
              systemctl start jenkins
              systemctl enable jenkins

              # Generate SSH key pair for Jenkins master to connect to agents
              sudo -u jenkins ssh-keygen -t rsa -N "" -f /var/lib/jenkins/.ssh/id_rsa

              # Set correct permissions for SSH keys
              sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa*
              EOF

  tags = {
    Name = "Jenkins-Master"
  }
}

# Jenkins Agent EC2 Instance
resource "aws_instance" "jenkins_agent" {
  ami           = "ami-0866a3c8686eaeeba"  # Ubuntu 24.04 AMI
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  security_groups = [aws_security_group.jenkins_sg.name]

  # User data script to allow the Jenkins master to connect via SSH
  user_data = file("jenkins-agent-userdata.sh")

  tags = {
    Name = "Jenkins-Agent"
  }
}
