variable "bucket_name" {
    default =  "tf-state-fahridd-2023"
    type = string
    description = "Bucket name"
}

variable "env" {
    description = "environment"
    type = string
    default = "prod"
  
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type for webserver."
  type        = string
}

variable "key_name" {
  description = "This is my key name"
  default     = "lenovo"
  type        = string
}

variable "ssh_from_port" {
  description = "Ingress port"
  default     = "22"
  type        = number
}

variable "ssh_to_port" {
  description = "Egress port"
  default     = "22"
  type        = number
}

variable "protocol" {
  description = "Which protocol it uses"
  default     = "tcp"
  type        = string
}