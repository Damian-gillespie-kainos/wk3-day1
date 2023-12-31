# resource "aws_cloudfront_distribution" "kpa-cloudfront-dg" {
#   enabled             = true
#   default_root_object = "index.html"
#   aliases             = [aws_s3_bucket.kpa-bucket-dg.bucket_regional_domain_name]

#   default_cache_behavior {
#     allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods         = ["GET", "HEAD"]
#     target_origin_id       = aws_s3_bucket.kpa-bucket-dg.bucket
#     viewer_protocol_policy = "redirect-to-https"
#     compress               = true

#     min_ttl     = 0
#     default_ttl = 5 * 60
#     max_ttl     = 60 * 60

#     forwarded_values {
#       query_string = true

#       cookies {
#         forward = "none"
#       }
#     }
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE"]
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   } 

#   origin {
#     domain_name = aws_s3_bucket.kpa-bucket-dg.bucket_regional_domain_name
#     origin_id   = aws_s3_bucket.kpa-bucket-dg.bucket

#     # s3_origin_config {
#     #   origin_access_identity = aws_cloudfront_origin_access_identity.gitbook.cloudfront_access_identity_path
#     # }
#   }
# }

# resource "aws_route53_zone" "kpa-r53-dg" {
#   name = "kpa-dg.com"
# }

# resource "aws_route53_record" "kpa-r53-record-dg" {
#   zone_id = aws_route53_zone.kpa-r53-dg.id
#   name = "kpa.dg.com"
#   type = "A"

#     alias {
#     name                   = aws_cloudfront_distribution.kpa-cloudfront-dg.domain_name
#     zone_id                = aws_cloudfront_distribution.kpa-cloudfront-dg.hosted_zone_id
#     evaluate_target_health = true
#   }
# }