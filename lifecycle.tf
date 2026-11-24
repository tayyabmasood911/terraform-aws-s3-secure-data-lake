# -----------------------------------------------------------------------------
# S3 Data Lake Multi-Tier Lifecycle & Storage Management
# -----------------------------------------------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "tiering" {
  bucket     = aws_s3_bucket.data_lake.id
  depends_on = [aws_s3_bucket_versioning.versioning]

  # Rule 1: Multi-stage automated transition for active data lake prefixes
  rule {
    id     = "data-lake-tiering"
    status = "Enabled"

    filter {
      prefix = ""
    }

    transition {
      days          = var.transition_days_ia
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.transition_days_glacier
      storage_class = "GLACIER"
    }

    transition {
      days          = var.transition_days_deep_archive
      storage_class = "DEEP_ARCHIVE"
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = var.expiration_days_noncurrent
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  # Rule 2: Temporary/Staging scratch files expiration
  rule {
    id     = "purge-temporary-staging"
    status = "Enabled"

    filter {
      prefix = "temp/"
    }

    expiration {
      days = 14
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}
