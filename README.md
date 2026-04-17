Terraform module which creates ActionTrail on Alibaba Cloud  

terraform-alicloud-actiontrail

Terraform module which creates a new action trail on Alibaba Cloud.

These types of resources are supported:

* [ActionTrail](https://www.terraform.io/docs/providers/alicloud/r/actiontrail.html)

**NOTE:** Currently, one alibaba cloud account only can create one actiontrail instance.

----------------------

Usage
-----

<div style="display: block;margin-bottom: 40px;"><div class="oics-button" style="float: right;position: absolute;margin-bottom: 10px;">
  <a href="https://api.aliyun.com/terraform?source=Module&activeTab=document&sourcePath=terraform-alicloud-modules%3A%3Aactiontrail&spm=docs.m.terraform-alicloud-modules.actiontrail&intl_lang=EN_US" target="_blank">
    <img alt="Open in AliCloud" src="https://img.alicdn.com/imgextra/i1/O1CN01hjjqXv1uYUlY56FyX_!!6000000006049-55-tps-254-36.svg" style="max-height: 44px; max-width: 100%;">
  </a>
</div></div>

You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

   ```hcl
     module "actiontrail" {
       source          = "terraform-alicloud-modules/actiontrail/alicloud"
       name            = "main-actiontrail"
       oss_bucket_name = "oss-bucket-for-actiontrail"
     }
    ```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION

## Conditional creation

Actiontrail delivering logs by OSS or SLS needs grant ram role and policy to it:

```hcl
module "actiontrail" {
    source          = "terraform-alicloud-modules/actiontrail/alicloud"
    name            = "main-actiontrail"
    oss_bucket_name = "oss-bucket-for-actiontrail"
    create_actiontrail_default_role = true
}
```
**NOTE**: If the ram role has been created, please ignore it and the module will fetch the existed and grant to the new ationtrail.

Create a new SLS project and use it to store actiontrail logs by specifying `log_project_name`:

```hcl
module "actiontrail" {
    source          = "terraform-alicloud-modules/actiontrail/alicloud"
    name            = "main-actiontrail"
    oss_bucket_name = "oss-bucket-for-actiontrail"
    log_project_name = "log-for-actiontrail"
}
```

## Notes
From the version v1.2.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/actiontrail"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.1.0:

```hcl
module "actiontrail" {
   source          = "terraform-alicloud-modules/actiontrail/alicloud"
   version         = "1.1.0"
   region          = "cn-beijing"
   name            = "main-actiontrail"
   oss_bucket_name = "oss-bucket-for-actiontrail"
   // ...
}
```

If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region = "cn-beijing"
}
module "actiontrail" {
   source          = "terraform-alicloud-modules/actiontrail/alicloud"
   name            = "main-actiontrail"
   oss_bucket_name = "oss-bucket-for-actiontrail"
   // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "actiontrail" {
   source          = "terraform-alicloud-modules/actiontrail/alicloud"
   providers       = {
      alicloud = alicloud.bj
   }
   name            = "main-actiontrail"
   oss_bucket_name = "oss-bucket-for-actiontrail"
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_actiontrail_trail.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/actiontrail_trail) | resource |
| [alicloud_log_project.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_oss_bucket.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_ram_policy.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_role.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |
| [alicloud_ram_roles.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |
| [alicloud_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_actiontrail_default_role"></a> [create\_actiontrail\_default\_role](#input\_create\_actiontrail\_default\_role) | Create a default ram role used to access OSS and SLS before launching a new CreateTrail. Default using the existed ram role. | `bool` | `false` | no |
| <a name="input_create_actiontrail_trail"></a> [create\_actiontrail\_trail](#input\_create\_actiontrail\_trail) | Whether to create a new actiontrail trail. | `bool` | `false` | no |
| <a name="input_create_log_project"></a> [create\_log\_project](#input\_create\_log\_project) | Whether to create a new log project. | `bool` | `false` | no |
| <a name="input_create_oss_bucket"></a> [create\_oss\_bucket](#input\_create\_oss\_bucket) | Whether to create a new OSS bucket based on variable oss\_bucket\_name. | `bool` | `false` | no |
| <a name="input_event_rw"></a> [event\_rw](#input\_event\_rw) | Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default value: Write. | `string` | `"Write"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. | `bool` | `true` | no |
| <a name="input_log_project_arn"></a> [log\_project\_arn](#input\_log\_project\_arn) | The unique ARN of the Log Service project used to the trail. | `string` | `""` | no |
| <a name="input_log_project_description"></a> [log\_project\_description](#input\_log\_project\_description) | Description of the log project. | `string` | `""` | no |
| <a name="input_log_project_name"></a> [log\_project\_name](#input\_log\_project\_name) | A name used to create a new log project when log\_project\_arn is not set. | `string` | `""` | no |
| <a name="input_oss_bucket_name"></a> [oss\_bucket\_name](#input\_oss\_bucket\_name) | A name of OSS bucket used to the trail delivers logs. | `string` | `""` | no |
| <a name="input_oss_key_prefix"></a> [oss\_key\_prefix](#input\_oss\_key\_prefix) | The prefix of the specified OSS bucket name. Default to empty. | `string` | `""` | no |
| <a name="input_policy_document"></a> [policy\_document](#input\_policy\_document) | Document of the RAM policy. | `string` | `""` | no |
| <a name="input_ram_policy_default_name"></a> [ram\_policy\_default\_name](#input\_ram\_policy\_default\_name) | A default ram policy used to ActionTrail default grant policy. It is valid when create\_actiontrail\_default\_role is true. | `string` | `""` | no |
| <a name="input_ram_policy_description"></a> [ram\_policy\_description](#input\_ram\_policy\_description) | Description of the RAM policy. | `string` | `""` | no |
| <a name="input_ram_policy_force"></a> [ram\_policy\_force](#input\_ram\_policy\_force) | This parameter is used for resource destroy. | `bool` | `true` | no |
| <a name="input_ram_role_default_name"></a> [ram\_role\_default\_name](#input\_ram\_role\_default\_name) | A default ram role used to grant ActionTrail to access OSS and SLS. It is valid when create\_actiontrail\_default\_role is true. | `string` | `""` | no |
| <a name="input_ram_role_description"></a> [ram\_role\_description](#input\_ram\_role\_description) | Description of the RAM role. | `string` | `""` | no |
| <a name="input_ram_role_force"></a> [ram\_role\_force](#input\_ram\_role\_force) | This parameter is used for resource destroy. | `bool` | `true` | no |
| <a name="input_role_document"></a> [role\_document](#input\_role\_document) | Authorization strategy of the RAM role. | `string` | `""` | no |
| <a name="input_sls_write_role_arn"></a> [sls\_write\_role\_arn](#input\_sls\_write\_role\_arn) | The unique ARN of the Log Service role. | `string` | `""` | no |
| <a name="input_this_module_name"></a> [this\_module\_name](#input\_this\_module\_name) | Name used on ActionTrail | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_actiontrail_id"></a> [this\_actiontrail\_id](#output\_this\_actiontrail\_id) | The actiontrail ID |
| <a name="output_this_actiontrail_name"></a> [this\_actiontrail\_name](#output\_this\_actiontrail\_name) | The actiontrail name |
| <a name="output_this_event_rw"></a> [this\_event\_rw](#output\_this\_event\_rw) | The event rw |
| <a name="output_this_log_project_arn"></a> [this\_log\_project\_arn](#output\_this\_log\_project\_arn) | The log project arn |
| <a name="output_this_log_project_id"></a> [this\_log\_project\_id](#output\_this\_log\_project\_id) | The log project id used to launch actiontrail |
| <a name="output_this_log_project_name"></a> [this\_log\_project\_name](#output\_this\_log\_project\_name) | The log project name used to launch actiontrail |
| <a name="output_this_oss_bucket_name"></a> [this\_oss\_bucket\_name](#output\_this\_oss\_bucket\_name) | The OSS bucket id used to launch actiontrail |
| <a name="output_this_oss_key_prefix"></a> [this\_oss\_key\_prefix](#output\_this\_oss\_key\_prefix) | The oss key prefix |
| <a name="output_this_ram_role_arn"></a> [this\_ram\_role\_arn](#output\_this\_ram\_role\_arn) | The RAM role arn used to launch actiontrail |
| <a name="output_this_ram_role_name"></a> [this\_ram\_role\_name](#output\_this\_ram\_role\_name) | The RAM role name used to launch actiontrail |
<!-- END_TF_DOCS -->


Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)