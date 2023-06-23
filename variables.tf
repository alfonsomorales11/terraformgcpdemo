# Terraform provider
variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-a"
}

variable "project_id" {
    type = string
    default = "myprojectid"
}

# Instances
variable "instance_names" {
    type = list(string)
    default = ["web-server-1" , "web-server-2", "database-server"]
}

variable "machine_type" {
    type = string
    default = "n1-standard-2"
}

variable "zone_instance" {
    type = string
    default = "us-east1-c"
}

variable "image" {
    type = string
    default = "debian-10-buster-v20220822"
}

variable "allow_stopping_for_update" {
    type = bool
    default = true
}

variable "network" {
    type = string
    default = "alfonso-demo-vpc-network"
}

variable "subnetworks" {
    type = list(string)
    default = ["subnet-01", "subnet-02", "subnet-03"]
}

# Bucket
variable "name_bucket" {
    type = string
    default = "alfonso-demo-bucket"
}

# Network
variable "vpc_region" {
    type = string
    default = "us-east1"
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