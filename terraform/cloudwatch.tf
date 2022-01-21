resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = local.app_name

  dashboard_body = templatefile("cloudwatch_dash.tpl", {
      "cluster_name" = nonsensitive(data.tfe_outputs.account.values.ecs_cluster_name),
      "service_name" = local.app_name,
      "region"       = data.aws_region.current.name,
      "memory_high"  = floor(local.service_ram * 0.9),
      "cpu_high"     = floor(local.service_cpu * 0.9)
  })
}