variable "extra_origin_attributes" {
  type        = list(string)
  default     = ["origin"]
  description = "Additional attributes to put onto the origin label"
}

variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
  default     = ""
}

variable "minimum_protocol_version" {
  type        = string
  description = <<-EOT
    Cloudfront TLS minimum protocol version.
    If `var.acm_certificate_arn` is unset, only "TLSv1" can be specified. See: [AWS Cloudfront create-distribution documentation](https://docs.aws.amazon.com/cli/latest/reference/cloudfront/create-distribution.html)
    and [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) for more information.
    Defaults to "TLSv1.2_2019" unless `var.acm_certificate_arn` is unset, in which case it defaults to `TLSv1`
    EOT
  default     = ""
}

variable "aliases" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}

variable "additional_bucket_policy" {
  type        = string
  default     = "{}"
  description = <<-EOT
    Additional policies for the bucket. If included in the policies, the variables `$${bucket_name}`, `$${origin_path}` and `$${cloudfront_origin_access_identity_iam_arn}` will be substituted.
    It is also possible to override the default policy statements by providing statements with `S3GetObjectForCloudFront` and `S3ListBucketForCloudFront` sid.
    EOT
}

variable "override_origin_bucket_policy" {
  type        = bool
  default     = true
  description = "When using an existing origin bucket (through var.origin_bucket), setting this to 'false' will make it so the existing bucket policy will not be overriden"
}

variable "origin_bucket" {
  type        = string
  default     = null
  description = "Name of an existing S3 bucket to use as the origin. If this is not provided, it will create a new s3 bucket using `var.name` and other context related inputs"
}

variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  type        = string
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path."
  default     = ""
}

variable "origin_force_destroy" {
  type        = bool
  default     = false
  description = "Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`)"
}

variable "compress" {
  type        = bool
  default     = true
  description = "Compress content for web requests that include Accept-Encoding: gzip in the request header"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "comment" {
  type        = string
  default     = "Managed by Terraform"
  description = "Comment for the origin access identity"
}

variable "log_standard_transition_days" {
  type        = number
  default     = 30
  description = <<-EOT
    Number of days after object creation to move Cloudfront Access Log objects to the infrequent access tier.
    Only effective if `cloudfront_access_log_create_bucket` is `true`.
    EOT
}

variable "log_glacier_transition_days" {
  type        = number
  default     = 60
  description = <<-EOT
    Number of days after object creation to move Cloudfront Access Log objects to the glacier tier.
    Only effective if `cloudfront_access_log_create_bucket` is `true`.
    EOT
}

variable "log_expiration_days" {
  type        = number
  default     = 90
  description = <<-EOT
    Number of days after object creation to expire Cloudfront Access Log objects.
    Only effective if `cloudfront_access_log_create_bucket` is `true`.
    EOT
}

variable "log_versioning_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    Set `true` to enable object versioning in the created Cloudfront Access Log S3 Bucket.
    Only effective if `cloudfront_access_log_create_bucket` is `true`.
    EOT
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior (incompatible with `cache_policy_id`)"
}

variable "query_string_cache_keys" {
  type        = list(string)
  description = "When `forward_query_string` is enabled, only the query string keys listed in this argument are cached (incompatible with `cache_policy_id`)"
  default     = []
}

variable "cors_allowed_headers" {
  type        = list(string)
  default     = ["*"]
  description = "List of allowed headers for S3 bucket"
}

variable "cors_allowed_methods" {
  type        = list(string)
  default     = ["GET"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket"
}

variable "cors_allowed_origins" {
  type        = list(string)
  default     = []
  description = "List of allowed origins (e.g. example.com, test.com) for S3 bucket"
}

variable "cors_expose_headers" {
  type        = list(string)
  default     = ["ETag"]
  description = "List of expose header in the response for S3 bucket"
}

variable "cors_max_age_seconds" {
  type        = number
  default     = 3600
  description = "Time in seconds that browser can cache the response for S3 bucket"
}

variable "forward_cookies" {
  type        = string
  default     = "none"
  description = "Specifies whether you want CloudFront to forward all or no cookies to the origin. Can be 'all' or 'none'"
}

variable "forward_header_values" {
  type        = list(string)
  description = "A list of whitelisted header values to forward to the origin (incompatible with `cache_policy_id`)"
  default     = ["Access-Control-Request-Headers", "Access-Control-Request-Method", "Origin"]
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Limit the protocol users can use to access content. One of `allow-all`, `https-only`, or `redirect-to-https`"
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. GET, PUT, POST, DELETE, HEAD)"
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = <<-EOT
    The unique identifier of the existing cache policy to attach to the default cache behavior.
    If not provided, this module will add a default cache policy using other provided inputs.
    EOT
}

variable "default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "trusted_signers" {
  type        = list(string)
  default     = []
  description = "The AWS accounts, if any, that you want to allow to create signed URLs for private content. 'self' is acceptable."
}

variable "trusted_key_groups" {
  type        = list(string)
  default     = []
  description = "A list of key group IDs that CloudFront can use to validate signed URLs or signed cookies."
}

variable "geo_restriction_type" {
  type = string

  # e.g. "whitelist"
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list(string)

  # e.g. ["US", "CA", "GB", "DE"]
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "parent_zone_id" {
  type        = string
  default     = ""
  description = "ID of the hosted zone to contain this record (or specify `parent_zone_name`). Requires `dns_alias_enabled` set to true"
}

variable "parent_zone_name" {
  type        = string
  default     = ""
  description = "Name of the hosted zone to contain this record (or specify `parent_zone_id`). Requires `dns_alias_enabled` set to true"
}

variable "dns_alias_enabled" {
  type        = bool
  default     = false
  description = "Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name`"
}

variable "custom_error_response" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  type = list(object({
    error_caching_min_ttl = string
    error_code            = string
    response_code         = string
    response_page_path    = string
  }))

  description = "List of one or more custom error response element maps"
  default     = []
}

variable "lambda_function_association" {
  type = list(object({
    event_type   = string
    include_body = bool
    lambda_arn   = string
  }))

  description = "A config block that triggers a lambda@edge function with specific actions"
  default     = []
}

variable "function_association" {
  type = list(object({
    event_type   = string
    function_arn = string
  }))

  description = <<-EOT
    A config block that triggers a CloudFront function with specific actions.
    See the [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#function-association)
    documentation for more information.
  EOT
  default     = []
}

variable "web_acl_id" {
  type        = string
  default     = ""
  description = "ID of the AWS WAF web ACL that is associated with the distribution"
}

variable "wait_for_deployment" {
  type        = bool
  default     = true
  description = "When set to 'true' the resource will wait for the distribution status to change from InProgress to Deployed"
}

variable "encryption_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the resource will have aes256 encryption enabled by default"
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders"
}

variable "redirect_all_requests_to" {
  type        = string
  default     = ""
  description = "A hostname to redirect all website requests for this distribution to. If this is set, it overrides other website settings"
}

variable "error_document" {
  type        = string
  default     = ""
  description = "An absolute path to the document to return in case of a 4XX error"
}

variable "routing_rules" {
  type        = string
  default     = ""
  description = "A json array containing routing rules describing redirect behavior and when redirects are applied"
}

variable "ipv6_enabled" {
  type        = bool
  default     = true
  description = "Set to true to enable an AAAA DNS record to be set as well as the A record"
}

variable "ordered_cache" {
  type = list(object({
    target_origin_id = string
    path_pattern     = string

    allowed_methods = list(string)
    cached_methods  = list(string)
    compress        = bool

    cache_policy_id          = string
    origin_request_policy_id = string

    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number

    forward_query_string  = bool
    forward_header_values = list(string)
    forward_cookies       = string

    lambda_function_association = list(object({
      event_type   = string
      include_body = bool
      lambda_arn   = string
    }))

    function_association = list(object({
      event_type   = string
      function_arn = string
    }))
  }))
  default     = []
  description = <<-EOT
    An ordered list of [cache behaviors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#cache-behavior-arguments) resource for this distribution.
    List in order of precedence (first match wins). This is in addition to the default cache policy.
    Set `target_origin_id` to `""` to specify the S3 bucket origin created by this module.
    EOT
}

variable "custom_origins" {
  type = list(object({
    domain_name = string
    origin_id   = string
    origin_path = string
    custom_headers = list(object({
      name  = string
      value = string
    }))
    custom_origin_config = object({
      http_port                = number
      https_port               = number
      origin_protocol_policy   = string
      origin_ssl_protocols     = list(string)
      origin_keepalive_timeout = number
      origin_read_timeout      = number
    })
  }))
  default     = []
  description = <<-EOT
    A list of additional custom website [origins](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments) for this distribution.
    EOT
}

variable "s3_origins" {
  type = list(object({
    domain_name = string
    origin_id   = string
    origin_path = string
    s3_origin_config = object({
      origin_access_identity = string
    })
  }))
  default     = []
  description = <<-EOT
    A list of S3 [origins](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments) (in addition to the one created by this module) for this distribution.
    S3 buckets configured as websites are `custom_origins`, not `s3_origins`.
    Specifying `s3_origin_config.origin_access_identity` as `null` or `""` will have it translated to the `origin_access_identity` used by the origin created by the module.
    EOT
}

variable "website_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    Set to true to enable the created S3 bucket to serve as a website independently of Cloudfront,
    and to use that website as the origin. See the README for details and caveats. See also `s3_website_password_enabled`.
    EOT
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "When set to 'true' the s3 origin bucket will have versioning enabled"
}

variable "deployment_principal_arns" {
  type        = map(list(string))
  default     = {}
  description = <<-EOT
    (Optional) Map of IAM Principal ARNs to lists of S3 path prefixes to grant `deployment_actions` permissions.
    Resource list will include the bucket itself along with all the prefixes. Prefixes should not begin with '/'.
    EOT
}

variable "deployment_actions" {
  type        = list(string)
  default     = ["s3:PutObject", "s3:PutObjectAcl", "s3:GetObject", "s3:DeleteObject", "s3:ListBucket", "s3:ListBucketMultipartUploads", "s3:GetBucketLocation", "s3:AbortMultipartUpload"]
  description = "List of actions to permit `deployment_principal_arns` to perform on bucket and bucket prefixes (see `deployment_principal_arns`)"
}

variable "cloudfront_origin_access_identity_iam_arn" {
  type        = string
  default     = ""
  description = "Existing cloudfront origin access identity iam arn that is supplied in the s3 bucket policy"
}

variable "cloudfront_origin_access_identity_path" {
  type        = string
  default     = ""
  description = "Existing cloudfront origin access identity path used in the cloudfront distribution's s3_origin_config content"
}

variable "custom_origin_headers" {
  type        = list(object({ name = string, value = string }))
  default     = []
  description = "A list of origin header parameters that will be sent to origin"
}

variable "origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS."
}

variable "block_origin_public_access_enabled" {
  type        = bool
  default     = false
  description = "When set to 'true' the s3 origin bucket will have public access block enabled"
}

variable "s3_access_logging_enabled" {
  type        = bool
  default     = null
  description = <<-EOF
    Set `true` to deliver S3 Access Logs to the `s3_access_log_bucket_name` bucket.
    Defaults to `false` if `s3_access_log_bucket_name` is empty (the default), `true` otherwise.
    Must be set explicitly if the access log bucket is being created at the same time as this module is being invoked.
    EOF
}

variable "s3_access_log_bucket_name" {
  type        = string # diff hint
  default     = ""     # diff hint
  description = "Name of the existing S3 bucket where S3 Access Logs will be delivered. Default is not to enable S3 Access Logging."
}

variable "s3_access_log_prefix" {
  type        = string # diff hint
  default     = ""     # diff hint
  description = "Prefix to use for S3 Access Log object keys. Defaults to `logs/$${module.this.id}`"
}

variable "cloudfront_access_logging_enabled" {
  type        = bool
  default     = true
  description = "Set true to enable delivery of Cloudfront Access Logs to an S3 bucket"
}

variable "cloudfront_access_log_create_bucket" {
  type        = bool
  default     = true
  description = <<-EOT
    When `true` and `cloudfront_access_logging_enabled` is also true, this module will create a new,
    separate S3 bucket to receive Cloudfront Access Logs.
    EOT
}

variable "extra_logs_attributes" {
  type        = list(string)
  default     = ["logs"]
  description = <<-EOT
    Additional attributes to add to the end of the generated Cloudfront Access Log S3 Bucket name.
    Only effective if `cloudfront_access_log_create_bucket` is `true`.
    EOT
}


variable "cloudfront_access_log_bucket_name" {
  type        = string # diff hint
  default     = ""     # diff hint
  description = <<-EOT
    When `cloudfront_access_log_create_bucket` is `false`, this is the name of the existing S3 Bucket where
    Cloudfront Access Logs are to be delivered and is required. IGNORED when `cloudfront_access_log_create_bucket` is `true`.
    EOT
}

variable "cloudfront_access_log_include_cookies" {
  type        = bool
  default     = false
  description = "Set true to include cookies in Cloudfront Access Logs"
}

variable "cloudfront_access_log_prefix" {
  type        = string # diff hint
  default     = ""     # diff hint
  description = "Prefix to use for Cloudfront Access Log object keys. Defaults to no prefix."
}

variable "distribution_enabled" {
  type        = bool
  default     = true
  description = "Set to `false` to create the distribution but still prevent CloudFront from serving requests."
}

variable "s3_website_password_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    If set to true, and `website_enabled` is also true, a password will be required in the `Referrer` field of the
    HTTP request in order to access the website, and Cloudfront will be configured to pass this password in its requests.
    This will make it much harder for people to bypass Cloudfront and access the S3 website directly via its website endpoint.
    EOT
}

variable "origin_groups" {
  type = list(object({
    primary_origin_id  = string
    failover_origin_id = string
    failover_criteria  = list(string)
  }))
  default     = []
  description = <<-EOT
    List of [Origin Groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#origin-group-arguments) to create in the distribution.
    The values of `primary_origin_id` and `failover_origin_id` must correspond to origin IDs existing in `var.s3_origins` or `var.custom_origins`.

    If `primary_origin_id` is set to `null` or `""`, then the origin id of the origin created by this module will be used in its place.
    This is to allow for the use case of making the origin created by this module the primary origin in an origin group.
  EOT
}

# Variables below here are DEPRECATED and should not be used anymore

variable "access_log_bucket_name" {
  type        = string
  default     = null
  description = "DEPRECATED. Use `s3_access_log_bucket_name` instead."
}

variable "logging_enabled" {
  type        = bool
  default     = null
  description = "DEPRECATED. Use `cloudfront_access_logging_enabled` instead."
}

variable "log_include_cookies" {
  type        = bool
  default     = null
  description = "DEPRECATED. Use `cloudfront_access_log_include_cookies` instead."
}

variable "log_prefix" {
  type        = string
  default     = null
  description = "DEPRECATED. Use `cloudfront_access_log_prefix` instead."
}

variable "realtime_log_config_arn" {
  type        = string
  default     = null
  description = "The ARN of the real-time log configuration that is attached to this cache behavior"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = true
  description = "Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests"
}
