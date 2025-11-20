variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure that only t2.micro is used
  # 1. Map from the object to the instance_type
  # 2. Map from the instance_type to a boolean indicating whether the value equals t2.micro
  # 3. Check wheter the list of booleans contains only true values

  validation {
    condition = alltrue([for config in var.ec2_instance_config_list : config.instance_type == "t2.micro"])
    # Mapping: Jedes Element (config) in ec2_instance_config_list wird gemappt mit jedem Element (config) mit Key instance_type, wird in Liste geschrieben
    error_message = "Only t2.micro instances are allowed"
    }

    validation {
    condition = alltrue([for config in var.ec2_instance_config_list : config.ami == "ubuntu"])
    # Mapping: Jedes Element (config) in ec2_instance_config_list wird gemappt mit jedem Element (config) mit Key ami, wird in Liste geschrieben
    error_message = "Only ubuntu amis are allowed"
    }
  
}