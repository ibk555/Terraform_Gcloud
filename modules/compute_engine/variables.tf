variable "gcp_compute_lab" {
  type        = string
  default     = "instance-403"
  description = "compute intance name"
  sensitive   = true
}

variable "machine_type" {
  type        = string
  default     = "n2-standard-2"
  description = "compute instance type"
}
