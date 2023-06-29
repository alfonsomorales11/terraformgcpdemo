# Remote backend (Google Cloud Storage bucket)
terraform {
  backend "gcs" {
    bucket  = "mybucket-alfonso"
    prefix  = "terraform/state"
  }
}

# 1 - Cloud Storage Bucket
module "bucket" {
  source = "./modules/storage"

  name = var.name_bucket
}

# 2 - Read only access to bucket
module "storage-iam" {
  source = "./modules/storage-iam"

  bucket = module.bucket.name
  member = "alfonsomorales@mycompany.com"

  depends_on = [module.bucket]
}

# 3 - VPC and subnets
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.0"

    project_id   = var.project_id
    network_name = var.network
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = var.subnetworks[0]
            subnet_ip             = "10.10.1.0/24"
            subnet_region         = var.vpc_region
        },
        {
            subnet_name           = var.subnetworks[1]
            subnet_ip             = "10.10.2.0/24"
            subnet_region         = var.vpc_region
        },
        {
            subnet_name           = var.subnetworks[2]
            subnet_ip             = "10.10.3.0/24"
            subnet_region         = var.vpc_region
        }
    ]
}

# 4 - Internet gateway

module "router" {
  source = "./modules/compute_router"

  name    = var.router_name
  network = module.vpc.network_name

  depends_on = [module.vpc]
}

module "router_nat" {
  source = "./modules/compute_router_nat"

  name               = var.nat_name
  region             = var.region
  router             = module.router.name

  depends_on = [module.router]
}

module "router_nat_log_config" {
  source = "./modules/compute_router_nat_log_config"

  router_nat_id  = module.router_nat.id

  depends_on = [module.router_nat]
}

# 5 - Security groups (or firewall rules for the three subnets)

module "firewall" {
  source = "./modules/firewall"

  name    = var.firewall_name
  network = module.vpc.network_name
  
  depends_on = [module.vpc]
}

#  6 - Separate default routes for each subnetwork
resource "google_compute_route" "subnet_default_route" {
  count             = length(var.subnetworks)
  name              = "subnet-default-route-${var.subnetworks[count.index]}"
  dest_range        = "0.0.0.0/0"
  network           = module.vpc.network_name
  next_hop_gateway  = module.router.self_link
  priority          = count.index * 10

  depends_on = [module.vpc , module.router]
}

# 7 - Web server instances
module "web1" {
    source = "./modules/instances/"

    instance_name = var.instance_names[0]
    machine_type = var.machine_type
    zone = var.zone
    allow_stopping_for_update = var.allow_stopping_for_update
    image = var.image
    network = module.vpc.network_name
    subnetwork = var.subnetworks[0]

    depends_on = [module.vpc]
}

module "web2" {
    source = "./modules/instances/"

    instance_name = var.instance_names[1]
    machine_type = var.machine_type
    zone = var.zone
    allow_stopping_for_update = var.allow_stopping_for_update
    image = var.image
    network = module.vpc.network_name
    subnetwork = var.subnetworks[1]

    depends_on = [module.vpc]
}

# 8 - Database server instance
module "database-server" {
    source = "./modules/instances/"

    instance_name = var.instance_names[2]
    machine_type = var.machine_type
    zone = var.zone
    allow_stopping_for_update = var.allow_stopping_for_update
    image = var.image
    network = module.vpc.network_name
    subnetwork = var.subnetworks[2]

    depends_on = [module.vpc]
}