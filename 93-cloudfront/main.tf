
resource "aws_cloudfront_distribution" "alb_distribution" {
  origin {
    domain_name              = local.origin_id
    origin_id                = local.origin_id
    custom_origin_config  {
        http_port              = 80 // Required to be set but not used
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "Some comment"
  default_root_object = "index.html"

  aliases = ["${var.project}-${var.env}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.cache_disabled_policy_id
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.origin_id

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.cache_optimized_policy_id
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.cache_optimized_policy_id
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = merge(
    { Name = "catalogue-${var.project}-${var.env}" },
    local.common_tags
  )


  viewer_certificate {
    acm_certificate_arn = local.aws_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

# route 53 record
resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "${var.project}-${var.env}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.alb_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.alb_distribution.hosted_zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}