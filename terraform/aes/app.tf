# THIS FILE WAS GENERATED AUTOMICALLY BY MDX-SERVICE 1.1.0.
# DO NOT MAKE MANUAL CHANGES TO THIS FILE OR THEY WILL BE OVERWRITTEN ON
# THE NEXT RUN. INSTEAD, YOU MAY CREATE ADDITIONAL .tf FILES NEXT TO THIS
# FILE AND TERRAFORM / MDX-SERVICE WILL COMPILE THOSE RESOURCES

variable "cluster" {
  default = "aes"
}

terraform {
  backend "s3" {
    bucket = "mdx-service"
    key    = "clusters/aes/apps/bedrockaccessgateway.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 2"
  region = "us-east-1"
}

module "api-80" {
  source = "git@github.com:mdx-dev/mdx-service.git//terraform/modules/ecs_service?ref=1.1.0"
  organization = "services"
  project = "bedrockaccessgateway"
  service = "api-80"
  cluster = "aes"
  desired_count = 1
  force_ssl = "true"
  health_check_grace_period_seconds = 0
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200
  container_definitions_json = "${file("task_definitions/api-80.json")}"
  secret_store = "aes-bedrockaccessgateway-api"
  loadbalancer                 = "internal"
  loadbalancer_listener_ports  = [443, 80]
  loadbalancer_target_port     = "80"
  loadbalancer_target_protocol = "http"
  loadbalancer_dns_entries = [
    {
      name    = "bedrock-proxy.aes.zdidata.com"
      zone_id = "Z05517162Y2J00A4QYRXW"
    },
  ]
  loadbalancer_healthcheck_path = "/health"
  loadbalancer_healthcheck_interval = "30"
  loadbalancer_healthcheck_healthy_threshold = "3"
  loadbalancer_healthcheck_unhealthy_threshold = "5"
}

