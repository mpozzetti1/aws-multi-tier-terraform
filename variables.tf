variable "db-port" {
  description = "Default port your Oracle Database uses (1521,1522,1523)"
  type        = number
  default     = 1521
}

variable "instance-type" {
  description = "Default EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "db-instance-type" {
  description = "Default EC2 Instance Type"
  type        = string
  default     = "db.t3.micro"
}

variable "db-password" {
  type    = string
  default = "Passowrd123!"
}

variable "linux-ami" {
  type    = string
  default = "ami-0f0c3baa60262d5b9"
}