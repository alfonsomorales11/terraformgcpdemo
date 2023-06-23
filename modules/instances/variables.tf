variable "instance_name" {
    type = string
    default = null
}

variable "machine_type" {
    type = string
}

variable "zone" {
    type = string
}

variable "image" {
    type = string 
}

# variable "script" {
#     type = string
# }

variable "allow_stopping_for_update" {
    type = bool
}

variable "network" {
    type = string
}

variable "subnetwork" {
    type = string
}