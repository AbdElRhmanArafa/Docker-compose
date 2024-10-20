output "jenkins_master_public_ip" {
  description = "The public IP address of the Jenkins master instance"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_agent_public_ip" {
  description = "The public IP address of the Jenkins agent instance"
  value       = aws_instance.jenkins_agent.public_ip
}
