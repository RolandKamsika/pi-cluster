variable "kubeconfig_path" {
  description = "Path to kubeconfig. Defaults to k3s system path."
  type        = string
  default     = ""
}

variable "namespace" {
  description = "Kubernetes namespace to deploy into"
  type        = string
  default     = "default"
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "my-app"
}

variable "chart_repository" {
  description = "Helm chart repository URL"
  type        = string
}

variable "chart_name" {
  description = "Helm chart name"
  type        = string
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
  default     = null
}

variable "values_override" {
  description = "Map of values to override in the chart"
  type        = any
  default     = {}
}