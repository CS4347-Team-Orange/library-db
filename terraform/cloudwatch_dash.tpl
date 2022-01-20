{
    "widgets": [
        {
            "height": 6,
            "width": 23,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "ECS/ContainerInsights", "RunningTaskCount", "ServiceName", "${service_name}", "ClusterName", "${cluster_name}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${region}",
                "annotations": {
                    "horizontal": [
                        {
                            "label": "MIN",
                            "value": 0.99,
                            "fill": "below"
                        }
                    ]
                },
                "period": 300
            }
        },
        {
            "height": 6,
            "width": 23,
            "y": 6,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "ECS/ContainerInsights", "CpuUtilized", "ServiceName", "${service_name}", "ClusterName", "${cluster_name}" ]
                ],
                "region": "${region}",
                "title": "CPU Utilization",
                "annotations": {
                    "horizontal": [
                        {
                            "label": "HIGH",
                            "value": ${cpu_high},
                            "fill": "above"
                        }
                    ]
                },
                "period": 300
            }
        },
        {
            "height": 6,
            "width": 23,
            "y": 12,
            "x": 0,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "ECS/ContainerInsights", "MemoryUtilized", "ServiceName", "${service_name}", "ClusterName", "${cluster_name}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${region}",
                "title": "Memory Utilization",
                "annotations": {
                    "horizontal": [
                        {
                            "color": "#d62728",
                            "label": "HIGH",
                            "value": ${memory_high},
                            "fill": "above"
                        }
                    ]
                },
                "period": 300
            }
        }
    ]
}