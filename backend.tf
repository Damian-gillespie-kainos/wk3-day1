resource "aws_s3_bucket" "kpa-bucket-dg" {
  bucket = "kpa-bucket-dg"
  acl    = "private"

  tags = {
    Name        = "kpa-bucket-dg"
  }
}

resource "aws_s3_bucket_ownership_controls" "kpa-bucket-controls-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "kpa-bucket-acl-dg" {
  bucket     = aws_s3_bucket.kpa-bucket-dg.id
  acl        = "private"
  depends_on = ["aws_s3_bucket_ownership_controls.kpa-bucket-controls-dg"]

}

resource "aws_s3_bucket_public_access_block" "kpa-block-public-access-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket_object" "kpa-object1-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id
  key    = "index"
  source = "~/AWS/index.html"
}

resource "aws_s3_bucket_object" "kpa-object2-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id
  key    = "css"
  source = "~/AWS/css/style.css"
}

resource "aws_s3_bucket_object" "kpa-object3-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id
  key    = "403"
  source = "~/AWS/403.html"
}

resource "aws_s3_bucket_object" "kpa-object4-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id
  key    = "404"
  source = "~/AWS/404.html"
}

resource "aws_s3_bucket_object" "kpa-object5-dg" {
  bucket = aws_s3_bucket.kpa-bucket-dg.id
  key    = "other"
  source = "~/AWS/other.html"
}
