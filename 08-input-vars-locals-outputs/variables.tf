# variable "aws_region" {
#   type = string
# }


variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "size of newly managed ec2 instances"

  validation {
    condition     = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    error_message = "Only supports t2.micro and t3.micro"
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })
  description = "The size and type of the root block volume for EC2 instances."

  default = {
    size = 10
    type = "gp3"
  }
}
