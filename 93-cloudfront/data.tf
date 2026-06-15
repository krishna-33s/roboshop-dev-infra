data "aws_cloudfront_cache_policy" "cachedisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "aws_certificate_arn" {
  name = "/${var.project}/${var.env}/aws_certificate_arn"
}
