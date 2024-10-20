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
---
### Pipeline Configuration

The Jenkins pipeline consists of the following stages:

#### 1. **Checkout Code from GitHub:**
   - The pipeline clones the repository from a **private GitHub repository** using a token for authentication.
   - The repository URL is stored in the environment variable `GIT_REPO`, and the main branch is checked out.

#### 2. **Build Docker Images:**
   - The pipeline builds Docker images for the three components:
     - **Frontend:** `hazem196/pizzafront:latest`
     - **Backend:** `hazem196/pizzaback:latest`
     - **Database:** `hazem196/pizzadb:latest`
   - The Dockerfiles for each component are located in their respective directories:
     - `Front-end/`
     - `Back-end/`
     - `Database/`

#### 3. **Push Images to Docker Hub:**
   - The Docker images are pushed to Docker Hub using the `dockerhub-token` credentials.
   - If an image fails to push, the pipeline logs the error.

#### 4. **Run Application:**
   - Docker containers for the database, backend, and frontend services are started.
   - The following ports are exposed:
     - **Database:** 27017
     - **Backend:** 3000
     - **Frontend:** 80 (mapped to 3001)

> **Note:** We are using a private GitHub repository in this pipeline, which requires proper authentication to access the codebase also we add  code here.
