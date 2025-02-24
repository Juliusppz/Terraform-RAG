output "instance_name" {
  description = "The name of the created instance."
  value       = google_compute_instance.rag_instance.name
}

output "instance_ip" {
  description = "The external IP address of the instance."
  value       = google_compute_instance.rag_instance.network_interface[0].access_config[0].nat_ip
}
