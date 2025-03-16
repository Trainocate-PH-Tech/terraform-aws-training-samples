variable "laravel_pf_port" {
  type = number
  description = "The Laravel app's port number to forward to the host"
  default = 8000
}

variable "db_hostname" {
  type = string
  description = "The DB's container name and hostname"
  default = "docker-db"
}

variable "db_password" {
  type = string
  description = "The database account's password (pointing to user laravel)"
  sensitive = true
  nullable = false
}

variable "db_name" {
  type = string
  description = "The app's database name to use"
  default = "laravel_app_db"
}
