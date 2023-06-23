variable "bucket" {
    type = string
    default = null
}

variable "role" {
    type = string
    default = "roles/storage.objectViewer"
}

variable "member" {
    type = string
    default = null
}