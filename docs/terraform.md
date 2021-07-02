<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.41.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.41.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns"></a> [dns](#module\_dns) | cloudposse/route53-alias/aws | 0.12.0 |
| <a name="module_logs"></a> [logs](#module\_logs) | cloudposse/s3-log-storage/aws | 0.20.0 |
| <a name="module_origin_label"></a> [origin\_label](#module\_origin\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [random_password.referer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_ssl_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_website_origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.cf_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_bucket_name"></a> [access\_log\_bucket\_name](#input\_access\_log\_bucket\_name) | DEPRECATED. Use `s3_access_log_bucket_name` instead. | `string` | `null` | no |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | Existing ACM Certificate ARN | `string` | `""` | no |
| <a name="input_additional_bucket_policy"></a> [additional\_bucket\_policy](#input\_additional\_bucket\_policy) | Additional policies for the bucket. If included in the policies, the variables `${bucket_name}`, `${origin_path}` and `${cloudfront_origin_access_identity_iam_arn}` will be substituted.<br>It is also possible to override the default policy statements by providing statements with `S3GetObjectForCloudFront` and `S3ListBucketForCloudFront` sid. | `string` | `"{}"` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | `list(string)` | `[]` | no |
| <a name="input_allow_ssl_requests_only"></a> [allow\_ssl\_requests\_only](#input\_allow\_ssl\_requests\_only) | Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests | `bool` | `true` | no |
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for AWS CloudFront | `list(string)` | <pre>[<br>  "DELETE",<br>  "GET",<br>  "HEAD",<br>  "OPTIONS",<br>  "PATCH",<br>  "POST",<br>  "PUT"<br>]</pre> | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_block_origin_public_access_enabled"></a> [block\_origin\_public\_access\_enabled](#input\_block\_origin\_public\_access\_enabled) | When set to 'true' the s3 origin bucket will have public access block enabled | `bool` | `false` | no |
| <a name="input_cache_policy_id"></a> [cache\_policy\_id](#input\_cache\_policy\_id) | The unique identifier of the existing cache policy to attach to the default cache behavior.<br>If not provided, this module will add a default cache policy using other provided inputs. | `string` | `null` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | List of cached methods (e.g. GET, PUT, POST, DELETE, HEAD) | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_cloudfront_access_log_bucket_name"></a> [cloudfront\_access\_log\_bucket\_name](#input\_cloudfront\_access\_log\_bucket\_name) | When `cloudfront_access_log_create_bucket` is `false`, this is the name of the existing S3 Bucket where<br>Cloudfront Access Logs are to be delivered and is required. IGNORED when `cloudfront_access_log_create_bucket` is `true`. | `string` | `""` | no |
| <a name="input_cloudfront_access_log_create_bucket"></a> [cloudfront\_access\_log\_create\_bucket](#input\_cloudfront\_access\_log\_create\_bucket) | When `true` and `cloudfront_access_logging_enabled` is also true, this module will create a new,<br>separate S3 bucket to receive Cloudfront Access Logs. | `bool` | `true` | no |
| <a name="input_cloudfront_access_log_include_cookies"></a> [cloudfront\_access\_log\_include\_cookies](#input\_cloudfront\_access\_log\_include\_cookies) | Set true to include cookies in Cloudfront Access Logs | `bool` | `false` | no |
| <a name="input_cloudfront_access_log_prefix"></a> [cloudfront\_access\_log\_prefix](#input\_cloudfront\_access\_log\_prefix) | Prefix to use for Cloudfront Access Log object keys. Defaults to no prefix. | `string` | `""` | no |
| <a name="input_cloudfront_access_logging_enabled"></a> [cloudfront\_access\_logging\_enabled](#input\_cloudfront\_access\_logging\_enabled) | Set true to enable delivery of Cloudfront Access Logs to an S3 bucket | `bool` | `true` | no |
| <a name="input_cloudfront_origin_access_identity_iam_arn"></a> [cloudfront\_origin\_access\_identity\_iam\_arn](#input\_cloudfront\_origin\_access\_identity\_iam\_arn) | Existing cloudfront origin access identity iam arn that is supplied in the s3 bucket policy | `string` | `""` | no |
| <a name="input_cloudfront_origin_access_identity_path"></a> [cloudfront\_origin\_access\_identity\_path](#input\_cloudfront\_origin\_access\_identity\_path) | Existing cloudfront origin access identity path used in the cloudfront distribution's s3\_origin\_config content | `string` | `""` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | Comment for the origin access identity | `string` | `"Managed by Terraform"` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | Compress content for web requests that include Accept-Encoding: gzip in the request header | `bool` | `true` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_cors_allowed_headers"></a> [cors\_allowed\_headers](#input\_cors\_allowed\_headers) | List of allowed headers for S3 bucket | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_cors_allowed_methods"></a> [cors\_allowed\_methods](#input\_cors\_allowed\_methods) | List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket | `list(string)` | <pre>[<br>  "GET"<br>]</pre> | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | List of allowed origins (e.g. example.com, test.com) for S3 bucket | `list(string)` | `[]` | no |
| <a name="input_cors_expose_headers"></a> [cors\_expose\_headers](#input\_cors\_expose\_headers) | List of expose header in the response for S3 bucket | `list(string)` | <pre>[<br>  "ETag"<br>]</pre> | no |
| <a name="input_cors_max_age_seconds"></a> [cors\_max\_age\_seconds](#input\_cors\_max\_age\_seconds) | Time in seconds that browser can cache the response for S3 bucket | `number` | `3600` | no |
| <a name="input_custom_error_response"></a> [custom\_error\_response](#input\_custom\_error\_response) | List of one or more custom error response element maps | <pre>list(object({<br>    error_caching_min_ttl = string<br>    error_code            = string<br>    response_code         = string<br>    response_page_path    = string<br>  }))</pre> | `[]` | no |
| <a name="input_custom_origin_headers"></a> [custom\_origin\_headers](#input\_custom\_origin\_headers) | A list of origin header parameters that will be sent to origin | `list(object({ name = string, value = string }))` | `[]` | no |
| <a name="input_custom_origins"></a> [custom\_origins](#input\_custom\_origins) | A list of additional custom website [origins](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments) for this distribution. | <pre>list(object({<br>    domain_name = string<br>    origin_id   = string<br>    origin_path = string<br>    custom_headers = list(object({<br>      name  = string<br>      value = string<br>    }))<br>    custom_origin_config = object({<br>      http_port                = number<br>      https_port               = number<br>      origin_protocol_policy   = string<br>      origin_ssl_protocols     = list(string)<br>      origin_keepalive_timeout = number<br>      origin_read_timeout      = number<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | Object that CloudFront return when requests the root URL | `string` | `"index.html"` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default amount of time (in seconds) that an object is in a CloudFront cache | `number` | `60` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_deployment_actions"></a> [deployment\_actions](#input\_deployment\_actions) | List of actions to permit `deployment_principal_arns` to perform on bucket and bucket prefixes (see `deployment_principal_arns`) | `list(string)` | <pre>[<br>  "s3:PutObject",<br>  "s3:PutObjectAcl",<br>  "s3:GetObject",<br>  "s3:DeleteObject",<br>  "s3:ListBucket",<br>  "s3:ListBucketMultipartUploads",<br>  "s3:GetBucketLocation",<br>  "s3:AbortMultipartUpload"<br>]</pre> | no |
| <a name="input_deployment_principal_arns"></a> [deployment\_principal\_arns](#input\_deployment\_principal\_arns) | (Optional) Map of IAM Principal ARNs to lists of S3 path prefixes to grant `deployment_actions` permissions.<br>Resource list will include the bucket itself along with all the prefixes. Prefixes should not begin with '/'. | `map(list(string))` | `{}` | no |
| <a name="input_distribution_enabled"></a> [distribution\_enabled](#input\_distribution\_enabled) | Set to `false` to create the distribution but still prevent CloudFront from serving requests. | `bool` | `true` | no |
| <a name="input_dns_alias_enabled"></a> [dns\_alias\_enabled](#input\_dns\_alias\_enabled) | Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name` | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | When set to 'true' the resource will have aes256 encryption enabled by default | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_error_document"></a> [error\_document](#input\_error\_document) | An absolute path to the document to return in case of a 4XX error | `string` | `""` | no |
| <a name="input_extra_logs_attributes"></a> [extra\_logs\_attributes](#input\_extra\_logs\_attributes) | Additional attributes to add to the end of the generated Cloudfront Access Log S3 Bucket name.<br>Only effective if `cloudfront_access_log_create_bucket` is `true`. | `list(string)` | <pre>[<br>  "logs"<br>]</pre> | no |
| <a name="input_extra_origin_attributes"></a> [extra\_origin\_attributes](#input\_extra\_origin\_attributes) | Additional attributes to put onto the origin label | `list(string)` | <pre>[<br>  "origin"<br>]</pre> | no |
| <a name="input_forward_cookies"></a> [forward\_cookies](#input\_forward\_cookies) | Specifies whether you want CloudFront to forward all or no cookies to the origin. Can be 'all' or 'none' | `string` | `"none"` | no |
| <a name="input_forward_header_values"></a> [forward\_header\_values](#input\_forward\_header\_values) | A list of whitelisted header values to forward to the origin (incompatible with `cache_policy_id`) | `list(string)` | <pre>[<br>  "Access-Control-Request-Headers",<br>  "Access-Control-Request-Method",<br>  "Origin"<br>]</pre> | no |
| <a name="input_forward_query_string"></a> [forward\_query\_string](#input\_forward\_query\_string) | Forward query strings to the origin that is associated with this cache behavior (incompatible with `cache_policy_id`) | `bool` | `false` | no |
| <a name="input_function_association"></a> [function\_association](#input\_function\_association) | A config block that triggers a CloudFront function with specific actions.<br>See the [aws\_cloudfront\_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#function-association)<br>documentation for more information. | <pre>list(object({<br>    event_type   = string<br>    function_arn = string<br>  }))</pre> | `[]` | no |
| <a name="input_geo_restriction_locations"></a> [geo\_restriction\_locations](#input\_geo\_restriction\_locations) | List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist) | `list(string)` | `[]` | no |
| <a name="input_geo_restriction_type"></a> [geo\_restriction\_type](#input\_geo\_restriction\_type) | Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist` | `string` | `"none"` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders | `string` | `"index.html"` | no |
| <a name="input_ipv6_enabled"></a> [ipv6\_enabled](#input\_ipv6\_enabled) | Set to true to enable an AAAA DNS record to be set as well as the A record | `bool` | `true` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_lambda_function_association"></a> [lambda\_function\_association](#input\_lambda\_function\_association) | A config block that triggers a lambda@edge function with specific actions | <pre>list(object({<br>    event_type   = string<br>    include_body = bool<br>    lambda_arn   = string<br>  }))</pre> | `[]` | no |
| <a name="input_log_expiration_days"></a> [log\_expiration\_days](#input\_log\_expiration\_days) | Number of days after object creation to expire Cloudfront Access Log objects.<br>Only effective if `cloudfront_access_log_create_bucket` is `true`. | `number` | `90` | no |
| <a name="input_log_glacier_transition_days"></a> [log\_glacier\_transition\_days](#input\_log\_glacier\_transition\_days) | Number of days after object creation to move Cloudfront Access Log objects to the glacier tier.<br>Only effective if `cloudfront_access_log_create_bucket` is `true`. | `number` | `60` | no |
| <a name="input_log_include_cookies"></a> [log\_include\_cookies](#input\_log\_include\_cookies) | DEPRECATED. Use `cloudfront_access_log_include_cookies` instead. | `bool` | `null` | no |
| <a name="input_log_prefix"></a> [log\_prefix](#input\_log\_prefix) | DEPRECATED. Use `cloudfront_access_log_prefix` instead. | `string` | `null` | no |
| <a name="input_log_standard_transition_days"></a> [log\_standard\_transition\_days](#input\_log\_standard\_transition\_days) | Number of days after object creation to move Cloudfront Access Log objects to the infrequent access tier.<br>Only effective if `cloudfront_access_log_create_bucket` is `true`. | `number` | `30` | no |
| <a name="input_log_versioning_enabled"></a> [log\_versioning\_enabled](#input\_log\_versioning\_enabled) | Set `true` to enable object versioning in the created Cloudfront Access Log S3 Bucket.<br>Only effective if `cloudfront_access_log_create_bucket` is `true`. | `bool` | `false` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | DEPRECATED. Use `cloudfront_access_logging_enabled` instead. | `bool` | `null` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum amount of time (in seconds) that an object is in a CloudFront cache | `number` | `31536000` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | Minimum amount of time that you want objects to stay in CloudFront caches | `number` | `0` | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | Cloudfront TLS minimum protocol version.<br>If `var.acm_certificate_arn` is unset, only "TLSv1" can be specified. See: [AWS Cloudfront create-distribution documentation](https://docs.aws.amazon.com/cli/latest/reference/cloudfront/create-distribution.html)<br>and [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html#secure-connections-supported-ciphers) for more information.<br>Defaults to "TLSv1.2\_2019" unless `var.acm_certificate_arn` is unset, in which case it defaults to `TLSv1` | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_ordered_cache"></a> [ordered\_cache](#input\_ordered\_cache) | An ordered list of [cache behaviors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#cache-behavior-arguments) resource for this distribution.<br>List in order of precedence (first match wins). This is in addition to the default cache policy.<br>Set `target_origin_id` to `""` to specify the S3 bucket origin created by this module. | <pre>list(object({<br>    target_origin_id = string<br>    path_pattern     = string<br><br>    allowed_methods = list(string)<br>    cached_methods  = list(string)<br>    compress        = bool<br><br>    cache_policy_id          = string<br>    origin_request_policy_id = string<br><br>    viewer_protocol_policy = string<br>    min_ttl                = number<br>    default_ttl            = number<br>    max_ttl                = number<br><br>    forward_query_string  = bool<br>    forward_header_values = list(string)<br>    forward_cookies       = string<br><br>    lambda_function_association = list(object({<br>      event_type   = string<br>      include_body = bool<br>      lambda_arn   = string<br>    }))<br><br>    function_association = list(object({<br>      event_type   = string<br>      function_arn = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_origin_bucket"></a> [origin\_bucket](#input\_origin\_bucket) | Name of an existing S3 bucket to use as the origin. If this is not provided, it will create a new s3 bucket using `var.name` and other context related inputs | `string` | `null` | no |
| <a name="input_origin_force_destroy"></a> [origin\_force\_destroy](#input\_origin\_force\_destroy) | Delete all objects from the bucket so that the bucket can be destroyed without error (e.g. `true` or `false`) | `bool` | `false` | no |
| <a name="input_origin_groups"></a> [origin\_groups](#input\_origin\_groups) | List of [Origin Groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#origin-group-arguments) to create in the distribution.<br>The values of `primary_origin_id` and `failover_origin_id` must correspond to origin IDs existing in `var.s3_origins` or `var.custom_origins`.<br><br>If `primary_origin_id` is set to `null` or `""`, then the origin id of the origin created by this module will be used in its place.<br>This is to allow for the use case of making the origin created by this module the primary origin in an origin group. | <pre>list(object({<br>    primary_origin_id  = string<br>    failover_origin_id = string<br>    failover_criteria  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_origin_path"></a> [origin\_path](#input\_origin\_path) | An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path. | `string` | `""` | no |
| <a name="input_origin_ssl_protocols"></a> [origin\_ssl\_protocols](#input\_origin\_ssl\_protocols) | The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. | `list(string)` | <pre>[<br>  "TLSv1",<br>  "TLSv1.1",<br>  "TLSv1.2"<br>]</pre> | no |
| <a name="input_override_origin_bucket_policy"></a> [override\_origin\_bucket\_policy](#input\_override\_origin\_bucket\_policy) | When using an existing origin bucket (through var.origin\_bucket), setting this to 'false' will make it so the existing bucket policy will not be overriden | `bool` | `true` | no |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id) | ID of the hosted zone to contain this record (or specify `parent_zone_name`). Requires `dns_alias_enabled` set to true | `string` | `""` | no |
| <a name="input_parent_zone_name"></a> [parent\_zone\_name](#input\_parent\_zone\_name) | Name of the hosted zone to contain this record (or specify `parent_zone_id`). Requires `dns_alias_enabled` set to true | `string` | `""` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | `string` | `"PriceClass_100"` | no |
| <a name="input_query_string_cache_keys"></a> [query\_string\_cache\_keys](#input\_query\_string\_cache\_keys) | When `forward_query_string` is enabled, only the query string keys listed in this argument are cached (incompatible with `cache_policy_id`) | `list(string)` | `[]` | no |
| <a name="input_realtime_log_config_arn"></a> [realtime\_log\_config\_arn](#input\_realtime\_log\_config\_arn) | The ARN of the real-time log configuration that is attached to this cache behavior | `string` | `null` | no |
| <a name="input_redirect_all_requests_to"></a> [redirect\_all\_requests\_to](#input\_redirect\_all\_requests\_to) | A hostname to redirect all website requests for this distribution to. If this is set, it overrides other website settings | `string` | `""` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_routing_rules"></a> [routing\_rules](#input\_routing\_rules) | A json array containing routing rules describing redirect behavior and when redirects are applied | `string` | `""` | no |
| <a name="input_s3_access_log_bucket_name"></a> [s3\_access\_log\_bucket\_name](#input\_s3\_access\_log\_bucket\_name) | Name of the existing S3 bucket where S3 Access Logs will be delivered. Default is not to enable S3 Access Logging. | `string` | `""` | no |
| <a name="input_s3_access_log_prefix"></a> [s3\_access\_log\_prefix](#input\_s3\_access\_log\_prefix) | Prefix to use for S3 Access Log object keys. Defaults to `logs/${module.this.id}` | `string` | `""` | no |
| <a name="input_s3_access_logging_enabled"></a> [s3\_access\_logging\_enabled](#input\_s3\_access\_logging\_enabled) | Set `true` to deliver S3 Access Logs to the `s3_access_log_bucket_name` bucket.<br>Defaults to `false` if `s3_access_log_bucket_name` is empty (the default), `true` otherwise.<br>Must be set explicitly if the access log bucket is being created at the same time as this module is being invoked. | `bool` | `null` | no |
| <a name="input_s3_origins"></a> [s3\_origins](#input\_s3\_origins) | A list of S3 [origins](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#origin-arguments) (in addition to the one created by this module) for this distribution.<br>S3 buckets configured as websites are `custom_origins`, not `s3_origins`.<br>Specifying `s3_origin_config.origin_access_identity` as `null` or `""` will have it translated to the `origin_access_identity` used by the origin created by the module. | <pre>list(object({<br>    domain_name = string<br>    origin_id   = string<br>    origin_path = string<br>    s3_origin_config = object({<br>      origin_access_identity = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_s3_website_password_enabled"></a> [s3\_website\_password\_enabled](#input\_s3\_website\_password\_enabled) | If set to true, and `website_enabled` is also true, a password will be required in the `Referrer` field of the<br>HTTP request in order to access the website, and Cloudfront will be configured to pass this password in its requests.<br>This will make it much harder for people to bypass Cloudfront and access the S3 website directly via its website endpoint. | `bool` | `false` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_trusted_key_groups"></a> [trusted\_key\_groups](#input\_trusted\_key\_groups) | A list of key group IDs that CloudFront can use to validate signed URLs or signed cookies. | `list(string)` | `[]` | no |
| <a name="input_trusted_signers"></a> [trusted\_signers](#input\_trusted\_signers) | The AWS accounts, if any, that you want to allow to create signed URLs for private content. 'self' is acceptable. | `list(string)` | `[]` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | When set to 'true' the s3 origin bucket will have versioning enabled | `bool` | `true` | no |
| <a name="input_viewer_protocol_policy"></a> [viewer\_protocol\_policy](#input\_viewer\_protocol\_policy) | Limit the protocol users can use to access content. One of `allow-all`, `https-only`, or `redirect-to-https` | `string` | `"redirect-to-https"` | no |
| <a name="input_wait_for_deployment"></a> [wait\_for\_deployment](#input\_wait\_for\_deployment) | When set to 'true' the resource will wait for the distribution status to change from InProgress to Deployed | `bool` | `true` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | ID of the AWS WAF web ACL that is associated with the distribution | `string` | `""` | no |
| <a name="input_website_enabled"></a> [website\_enabled](#input\_website\_enabled) | Set to true to enable the created S3 bucket to serve as a website independently of Cloudfront,<br>and to use that website as the origin. See the README for details and caveats. See also `s3_website_password_enabled`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aliases"></a> [aliases](#output\_aliases) | Aliases of the CloudFront distribution. |
| <a name="output_cf_arn"></a> [cf\_arn](#output\_cf\_arn) | ARN of AWS CloudFront distribution |
| <a name="output_cf_domain_name"></a> [cf\_domain\_name](#output\_cf\_domain\_name) | Domain name corresponding to the distribution |
| <a name="output_cf_etag"></a> [cf\_etag](#output\_cf\_etag) | Current version of the distribution's information |
| <a name="output_cf_hosted_zone_id"></a> [cf\_hosted\_zone\_id](#output\_cf\_hosted\_zone\_id) | CloudFront Route 53 zone ID |
| <a name="output_cf_id"></a> [cf\_id](#output\_cf\_id) | ID of AWS CloudFront distribution |
| <a name="output_cf_identity_iam_arn"></a> [cf\_identity\_iam\_arn](#output\_cf\_identity\_iam\_arn) | CloudFront Origin Access Identity IAM ARN |
| <a name="output_cf_origin_groups"></a> [cf\_origin\_groups](#output\_cf\_origin\_groups) | List of Origin Groups in the CloudFront distribution. |
| <a name="output_cf_origin_ids"></a> [cf\_origin\_ids](#output\_cf\_origin\_ids) | List of Origin IDs in the CloudFront distribution. |
| <a name="output_cf_primary_origin_id"></a> [cf\_primary\_origin\_id](#output\_cf\_primary\_origin\_id) | The ID of the origin created by this module. |
| <a name="output_cf_s3_canonical_user_id"></a> [cf\_s3\_canonical\_user\_id](#output\_cf\_s3\_canonical\_user\_id) | Canonical user ID for CloudFront Origin Access Identity |
| <a name="output_cf_status"></a> [cf\_status](#output\_cf\_status) | Current status of the distribution |
| <a name="output_logs"></a> [logs](#output\_logs) | Log bucket resource |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | Name of origin S3 bucket |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | ARN of origin S3 bucket |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | Domain of origin S3 bucket |
| <a name="output_s3_bucket_policy"></a> [s3\_bucket\_policy](#output\_s3\_bucket\_policy) | Final computed S3 bucket policy |
<!-- markdownlint-restore -->
