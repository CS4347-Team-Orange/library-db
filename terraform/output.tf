output "db_host" { 
    value = "db.${local.service_discovery_root}"
}

output "db_username" { 
    value = local.db_username
}

output "db_password" { 
    value = nonsensitive(random_password.db_password.result)
}

output "db_name" { 
    value = local.db_name
}