provider "aws" {
  region = "ap-southeast-1"  # Update with your desired region
}

resource "aws_s3_bucket" "static_website" {
  bucket = "your-unique-bucket-name"  # Update with your desired bucket name
  acl    = "public-read"

  website {
    index_document = "index.html"  # Update with your index document name
    error_document = "error.html"  # Update with your error document name
  }
}

# Optional: CloudFront Distribution
resource "aws_cloudfront_distribution" "static_website_cdn" {
  origin {
    domain_name = aws_s3_bucket.static_website.website_endpoint
    origin_id   = "S3Origin"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Other configurations like SSL certificate, caching settings, etc. can be added here.
}
