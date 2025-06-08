resource "google_compute_instance" "default" {
  name         = var.gcp_compute_lab
  machine_type = var.n2-standard-2
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

}

# resource "google_storage_bucket" "static-site" {
#   name          = "image-store.com"
#   location      = "EU"
#   force_destroy = true

#   uniform_bucket_level_access = true

#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "404.html"
#   }
#   cors {
#     origin          = ["http://image-store.com"]
#     method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
#     response_header = ["*"]
#     max_age_seconds = 3600
#   }
# }

resource "google_bigquery_dataset" "default" {
  dataset_id                  = "dinosaur"
  friendly_name               = "dinosaur"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = var.dataset_id
  table_id   = "dec"
  deletion_protection = false

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "device",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Name of device"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  },
  {
    "name": "log_date",
    "type": "DATE",
    "mode": "NULLABLE",
    "description": ""
  }
]
EOF


}

# resource "google_bigquery_table" "sheet" {
#   dataset_id = "bootcamp"
#   table_id   = "sheet"

#   external_data_configuration {
#     autodetect    = true
#     source_format = "GOOGLE_SHEETS"

#     google_sheets_options {
#       skip_leading_rows = 1
#     }

#     source_uris = [
#       "https://docs.google.com/spreadsheets/d/123456789012345",
#     ]
#   }
# }

module "bigquery" {
  source     = "./modules/bigquery"
  dataset_id = "dinosaur"
}

module "compute_engine" {
  source          = "./modules/compute_engine"
  gcp_compute_lab = "compute-lab"
  machine_type    = "n2-standard-2"
}
