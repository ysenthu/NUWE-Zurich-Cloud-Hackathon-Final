output "app_installation" {
  value = base64encode(templatefile("${path.module}/user-data.tpl", { bucket_name = var.bucket_name }))
}