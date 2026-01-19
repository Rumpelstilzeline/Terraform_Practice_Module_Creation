#######################
# General Information
######################

variable "project_name" {
  type = string
  description = "name of our project"
}


#######################
# Database Configuration
######################

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
  description = "allowed instance classes"

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier"
  }

}

variable "storage_size" {
  type    = number
  default = 10
  description = "the amount of storage to allocate to the database. Should be between 5GB and 10GB."

  validation {
    condition     = var.storage_size > 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5GB and 10GB"
  }

}


variable "engine" {
  type    = string
  default = "postgres-latest"
  description = "Which engine to use for database, currently only postgres supported"

  validation {
    condition     = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "DB engine must be postgres-latest or postgres-14"
  }

}

#######################
# DB Credentials
######################

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0
    )

    error_message = "Password must contain at least 1 character and 1 digit"
  }

}


#######################
# Database Network
######################

variable "subnet_ids" {
  type = list(string)
  
}

variable "security_group_ids" {
  type = list(string)
  
}