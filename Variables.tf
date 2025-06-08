variable "gcp_compute_lab" {
  type      = string
  default   = "instance-403"
  sensitive = true
}

variable "n2-standard-2" {
  type        = string
  default     = "n2-standard-2"
  description = "instance-404"
}

variable "dataset_id" {
  type = string
}
