resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "rm -rf ${var.project_root}dist && rm -rf ${var.project_root}package.zip && mkdir ${var.project_root}dist && cp -r ${var.project_root}src/* ${var.project_root}dist/. && pip install -r ${var.project_root}src/requirements.txt -t ${var.project_root}dist/"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
resource "aws_s3_bucket_object" "object" {
  bucket = var.bucket_name
  key    = var.object_key
  source = data.archive_file.artifact.output_path

  etag = data.archive_file.artifact.output_sha256
}
