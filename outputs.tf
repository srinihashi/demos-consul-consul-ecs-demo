################################################################################
# VPC
################################################################################

output "region" {
  value = var.vpc_region
}

output "vpc-id" {
  value = module.vpc.vpc_id
}

/****

################################################################################
# ECS Service(s)
################################################################################

output "consul_server-ips" {
  value = local.consul_dns
}

output "ecs_cluster_name" {
  value = data.aws_ecs_cluster.ecs_cluster.cluster_name
}

################################################################################
# Consul Service(s)
################################################################################

output "consulBootstrapToken" {
  value = aws_secretsmanager_secret.bootstrap_token.arn
}

output "Consul_ssh" {
  value = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.consul[0].public_dns}"
}

output "ConsulServer" {
  value = "http://${aws_instance.consul[0].public_dns}:8500"
}

output "API-Gateway_ssh" {
  value = "API-Gateway ssh"
  #value = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.consul_api_gateway[0].public_dns}"
}

output "Consul_Security_Groups" {
  value = "aws_security_group.consul_sg.id" #aws_security_group.consul_sg.id
}

*****/