output "external_ip_address" {
  description = "Public IP address of the Kittygram VM."
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

output "kittygram_url" {
  description = "URL to use in tests.yml after deployment."
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}:${var.gateway_port}"
}

output "app_bucket_name" {
  description = "Object Storage bucket created for the project."
  value       = yandex_storage_bucket.kittygram.bucket
}
