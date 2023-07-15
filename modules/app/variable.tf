variable "project_root" {
  description = "Root Path defined as relative to terraform invoke path"
  default     = "../../"
  type        = string

}
variable "bucket_name" {
  description = "bucket name to store the file."
  type        = string
}

variable "object_key" {
  description = "object key for the file."
  type        = string
}
