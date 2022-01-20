// IAM 

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.app_name}-ecsTaskExecutionRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${local.app_name}-ecsTaskRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

// Service discovery

resource "aws_service_discovery_public_dns_namespace" "this" {
  name        = "db.${local.service_discovery_root}"
  description = "Service Discovery Namespace for ${local.app_name}"
}

resource "aws_service_discovery_service" "this" {
  name = local.app_name

  dns_config {
    namespace_id = aws_service_discovery_public_dns_namespace.this.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}

// EFS

resource "aws_efs_file_system" "this" {
  creation_token = "${local.app_name}"
}

// ECS

resource "aws_ecs_task_definition" "this" {
  network_mode             = "awsvpc"
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  cpu                      = local.service_cpu
  memory                   = local.service_ram
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = templatefile(
  "${path.module}/task-definition.json", {
    "name" = local.app_name,
    "image" = var.container_uri,
    "ram" = local.service_ram,
    "cpu" = local.service_cpu,
    "region" = data.aws_region.current.name,
    "app_name" = local.app_name,
    "postgres_user" = local.db_username,
    "postgres_password" = random_password.db_password.result,
    "postgres_database" = local.db_name
  })

  volume {
    name = local.app_name

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.this.id
    }
  }
}

resource "aws_ecs_service" "main" {
  name                               = "${local.app_name}"
  cluster                            = nonsensitive(data.tfe_outputs.account.values.ecs_cluster_arn)
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [nonsensitive(data.tfe_outputs.account.values.cluster_security_group_id),aws_security_group.this.id]
    subnets          = nonsensitive(data.tfe_outputs.account.values.vpc_private_subnets)
    assign_public_ip = false
  }

  service_registries { 
    registry_arn = aws_service_discovery_service.this.arn
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = local.app_name
}

resource "random_password" "db_password" {
  length           = 16
  special          = false
}

// Security Group

resource "aws_security_group" "this" { 
    name                 = "${local.app_name}"
    description          = "Tier security group for ${local.app_name}"
    vpc_id               = nonsensitive(data.tfe_outputs.account.values.vpc_id)
    
    ingress {
        protocol        = "tcp"
        from_port       = 5432
        to_port         = 5432
        security_groups = [ nonsensitive(data.tfe_outputs.account.values.cluster_security_group_id) ]
    }

    ingress {
        protocol        = "tcp"
        from_port       = 5432
        to_port         = 5432
        self            = true
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}
