# Input variables for EC2 configuration
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the key pair for SSH access"
  type        = string
  default     = "Callange"
}