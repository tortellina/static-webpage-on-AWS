variable "cidr_block" {
  description = "cidr for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1" {
  description = "cidr public subnet 1"
  type        = string
  default     = "10.0.0.0/24"

}

variable "az_public_subnet_1" {
  description = "az public subnet 1"
  type        = string
  default     = "eu-north-1c"

}

variable "public_subnet_2" {
  description = "cidr public subnet 2"
  type        = string
  default     = "10.0.1.0/24"

}

variable "az_public_subnet_2" {
  description = "az public subnet 2"
  type        = string
  default     = "eu-north-1b"

}

variable "private_subnet_1" {
  description = "cidr private subnet 1"
  type        = string
  default     = "10.0.2.0/24"

}

variable "az_private_subnet_1" {
  description = "az public subnet 1"
  type        = string
  default     = "eu-north-1c"

}

variable "private_subnet_2" {
  description = "cidr public subnet 2"
  type        = string
  default     = "10.0.3.0/24"

}

variable "az_private_subnet_2" {
  description = "az public subnet 2"
  type        = string
  default     = "eu-north-1b"

}

variable "instance_type" {
  description = "type of EC2 instances"
  type        = string
  default     = "t3.micro"

}

variable "instance_ami" {
  description = "instance ami"
  type        = string
  default     = "ami-016038ae9cc8d9f51"
}

variable "availability_zone" {
  description = "avaiability zone"
  type        = string
  default     = "eu-north-1"
}

