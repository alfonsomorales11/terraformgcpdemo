variable "name" {
    type = string
    default = null
}

variable "region" {
    type = string
    default = null
}

variable "router" {
    type = string
    default = null
}

variable "nat_ip_allocate_option" {
    type = string
    default = "AUTO_ONLY"
}