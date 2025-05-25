variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  default = "ibrahim-key"
}

variable "ami" {
  description = "Amazon Machine Image ID"
  default     = "ami-0953476d60561c955"  
}

