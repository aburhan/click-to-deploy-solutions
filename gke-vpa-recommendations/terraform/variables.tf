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

locals {
  application_name  = "vpa-recommendations-to-bq"
  schedule          = "0 23 * * *"
  schedule_timezone = "America/New_York"
  run_memory = "1Gi"
  run_cpu = "1"
  resource_labels = merge(var.resource_labels, {
    deployed_by = "cloudbuild"
    repo        = "click-to-deploy-solutions"
    solution    = "gke-vpa-recommendations"
    terraform   = "true"
  })
}

variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "resource_labels" {
  type        = map(string)
  description = "Resource labels"
  default     = {}
}