###resources for VMs
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
  description = "Resources for VMs (web and db)"
}


###vm vars (web)
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for the VM"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of the VM"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID for the VM"
}

#variable "vm_web_cores" {
#  type        = number
#  default     = 2
#  description = "Number of CPU cores for the VM"
#}

#variable "vm_web_memory" {
#  type        = number
#  default     = 2
#  description = "Amount of memory (GB) for the VM"
#}

#variable "vm_web_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Core fraction for the VM"
#}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Whether the VM is preemptible"
}

###vm vars (db)
variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for the DB VM"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of the DB VM"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID for the DB VM"
}

# variable "vm_db_cores" {
#  type        = number
#  default     = 2
#  description = "Number of CPU cores for the DB VM"
#}

#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#  description = "Amount of memory (GB) for the DB VM"
#}

#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Core fraction for the DB VM"
#}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Whether the DB VM is preemptible"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for the DB VM"
}
