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


resource "google_cloud_run_v2_job" "metric_exporter" {
  name         = local.application_name
  location     = var.region
  launch_stage = "BETA"

  template {
    task_count  = 1
    parallelism = 0
    labels      = local.resource_labels
    template {
      service_account = google_service_account.service_account.email
      timeout         = "3600s"
      containers {
        image = "us-docker.pkg.dev/google-samples/containers/gke/metrics-exporter:latest"

        env {
          name  = "PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION"
          value = "python"
        }
        env {
          name  = "PROJECT_ID"
          value = var.project_id
        }
        resources {
          limits = {
            memory = local.run_memory
            cpu = local.run_cpu
          }
        }
      }
    }
  }
}

