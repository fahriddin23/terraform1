variable "deletion_window_in_days" {
    description = "delete kms key in 7 days"
    type = number
}

variable "description" {
    description = "description of the key"
    type = string
}

variable "enabled" {
    description = "enabled to is by default true "
    type = bool
}

variable "enable_key_rotation" {
    description = "enable key rotation is true/false"
    type = bool
}

