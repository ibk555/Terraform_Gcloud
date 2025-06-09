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
