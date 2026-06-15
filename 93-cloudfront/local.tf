locals {
    origin_id = "frontend-${var.env}.${var.domain_name}"
    cache_disabled_policy_id = data.aws_cloudfront_cache_policy.cachedisabled.id
    cache_optimized_policy_id = data.aws_cloudfront_cache_policy.optimized.id
    aws_certificate_arn = data.aws_ssm_parameter.aws_certificate_arn.value
    common_tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}