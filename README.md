# Docker-compose

#### 1. Prerequisites
- AWS account and credentials configured.
- Terraform installed locally.
- An SSH key pair for EC2 instances (replace `var.key_pair_name` with your actual key pair).
- Ensure security groups allow access to SSH, HTTP, and Jenkins UI ports.

#### 2. Security Group Configuration
In the Terraform code, a security group (`jenkins_sg`) is created allowing:
- **Port 22 (SSH)**: for remote access.
- **Port 8080**: for Jenkins Web UI.
- **Port 80**: for the application web interface.

#### 3. Jenkins Master EC2 Instance Setup
- AMI used: `ami-02aa54e145c19cdda` (pre-installed Jenkins).
- Instance Type: Defined by `var.instance_type`, e.g., `t2.micro`.
- After the instance is launched, Jenkins is started automatically via the `user_data` script.
- The Master instance is responsible for managing Jenkins jobs and orchestrating the build processes.

#### 4. Jenkins Agent EC2 Instance Setup
- AMI used: `ami-0866a3c8686eaeeba` (Ubuntu 24.04).
- The `jenkins-agent-userdata.sh` script installs the required software such as Docker, and sets up SSH keys for communication with the Jenkins Master.
- The Agent instance executes Jenkins build steps and runs Docker containers as needed.
