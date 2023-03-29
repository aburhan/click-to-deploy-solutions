# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_bigquery_dataset" "dataset" {
  dataset_id  = "metric_export"
  description = "GKE VPA recommendations data"
  location    = var.region
  labels      = local.resource_labels
}

resource "google_bigquery_table" "metrics" {
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
  table_id            = "mql_metrics"
  description         = "GKE system and scale metrics"
  deletion_protection = false

  time_partitioning {
    type = "DAY"
  }

  labels = local.resource_labels

  schema = <<EOF
[
    {
      "name": "metric_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "location",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "project_id",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "cluster_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "controller_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "controller_type",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "namespace_name",
      "type": "STRING",
      "mode": "NULLABLE"
    },
    {
      "name": "points",
      "type": "INTEGER",
      "mode": "NULLABLE"
    }
    ,
    {
      "name": "tstamp",
      "type": "FLOAT",
      "mode": "NULLABLE"
    }
  ]
EOF

}
resource "google_bigquery_table" "recommendations" {
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
  table_id            = "vpa_container_recommendations"
  description         = "GKE VPA recommendations"
  deletion_protection = false

  time_partitioning {
    type  = "DAY"
    field = "recommendation_timestamp"
  }

  labels = local.resource_labels

  schema = <<EOF
[
    {
      "name": "recommendation_timestamp",
      "mode": "Required",
      "type": "TIMESTAMP"
    },
    {
        "name": "location",
        "mode": "Required",
        "type": "STRING"
    },
    {
      "name": "project_id",
      "mode": "Required",
      "type": "STRING"
    },
    {
      "name": "cluster_name",
      "mode": "Required",
      "type": "STRING"
    },
    {
        "name": "controller_name",
        "mode": "Required",
        "type": "STRING"
    },
    {
        "name": "controller_type",
        "mode": "Required",
        "type": "STRING"
    },
    {
      "name": "namespace_name",
      "mode": "Required",
      "type": "STRING"
    },
    {
      "name": "container_count",
      "mode": "NULLABLE",
      "type": "INTEGER"
    },
    {
        "name": "cpu_limit_cores",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
      "name": "cpu_requested_cores",
      "mode": "NULLABLE",
      "type": "INTEGER"
    },
    {
        "name": "memory_limit_bytes",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "memory_requested_bytes",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "memory_request_max_recommendations",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "mem_qos",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "cpu_qos",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "memory_limit_recommendations",
        "mode": "NULLABLE",
        "type": "INTEGER"
      },
    {
      "name": "cpu_request_recommendations",
      "mode": "NULLABLE",
      "type": "INTEGER"
    },
    {
        "name": "cpu_limit_recommendations",
        "mode": "NULLABLE",
        "type": "INTEGER"
      },
    {
        "name": "cpu_delta",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "mem_delta",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "priority",
        "mode": "NULLABLE",
        "type": "INTEGER"
    },
    {
        "name": "mem_provision_status",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "mem_provision_risk",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "cpu_provision_status",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "cpu_provision_risk",
        "mode": "NULLABLE",
        "type": "STRING"
    },
    {
        "name": "latest",
        "mode": "NULLABLE",
        "type": "BOOLEAN"
    }

  ]
EOF

}
