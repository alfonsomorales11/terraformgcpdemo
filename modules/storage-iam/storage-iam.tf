resource "google_storage_bucket_iam_member" "example_bucket_read_only" {
  bucket = var.bucket
  role   = var.role
  member = var.member
}