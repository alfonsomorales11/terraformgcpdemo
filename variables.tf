variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-a"
}

variable "name_bucket" {
    type = string
    default = "alfonso-demo-bucket"
}

variable "project_id" {
    type = string
    default = "myprojectid"
}

variable "network" {
    type = string
    default = "alfonso-demo-vpc-network"
}

variable "subnetworks" {
    type = list(string)
    default = ["subnet-01", "subnet-02", "subnet-03"]
}

variable "router_name" {
    type = string
    default = "alfonso-demo-router"
}

variable "nat_name" {
    type = string
    default = "alfonso-demo-natname"
}

variable "firewall_name" {
    type = string
    default = "alfonso-demo-firewall"
}

variable "instance_names" {
    type = list(string)
    default = ["web-server-1" , "web-server-2", "database-server"]
}

variable "machine_type" {
    type = string
    default = "n1-standard-2"
}

variable "image" {
    type = string
    default = "debian-10-buster-v20220822"
}

variable "allow_stopping_for_update" {
    type = bool
    default = true
}