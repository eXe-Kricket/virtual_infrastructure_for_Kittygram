variable "yc_token" {
  description = "Yandex Cloud OAuth token or IAM token."
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID."
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud folder ID."
  type        = string
}

variable "access_key" {
  description = "Static access key for Yandex Object Storage."
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Static secret key for Yandex Object Storage."
  type        = string
  sensitive   = true
}

variable "yc_zone" {
  description = "Availability zone for Kittygram resources."
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Compute instance name."
  type        = string
  default     = "kittygram-vm"
}

variable "platform_id" {
  description = "Yandex Compute platform ID."
  type        = string
  default     = "standard-v3"
}

variable "cores" {
  description = "Number of vCPU cores."
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM size in GB."
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20
}

variable "ssh_public_key" {
  description = "Public SSH key for the ubuntu user."
  type        = string
}

variable "gateway_port" {
  description = "Public HTTP port used by the Kittygram gateway."
  type        = number
  default     = 9003
}

variable "state_bucket_name" {
  description = "Name of the already existing bucket used for Terraform state."
  type        = string
  default     = ""
}

variable "app_bucket_name" {
  description = "Name of the Object Storage bucket created for the project."
  type        = string
}
