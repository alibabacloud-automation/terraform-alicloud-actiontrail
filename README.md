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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | Name used on ActionTrail | string | - | yes |
| oss_bucket_name | A name of OSS bucket used to the trail delivers logs | string | - | yes |
| create_oss_bucket | Whether to create a new OSS bucket based on variable oss_bucket_name | bool | false | no |
| create_actiontrail_default_role | Create a default ram role used to access OSS and SLS before launching a new CreateTrail. Default using the existed ram role | bool | false | no |
| ram_role_default_name | A default ram role used to grant ActionTrail to access OSS and SLS. It is valid when create_actiontrail_default_role is true. The value should be equals to the name of the file AliyunActionTrailDefaultRole.json | string | AliyunActionTrailDefaultRole | no |
| ram_policy_default_name | A default ram policy used to ActionTrail default grant policy. It is valid when create_actiontrail_default_role is true. The value should be equals to the name of the file AliyunActionTrailRolePolicy.json | string | AliyunActionTrailRolePolicy | no |
| log_project_arn | The unique ARN of the Log Service project used to the trail | string | "" | no |
| log_project_name | A name used to create a new log project when log_project_arn is not set | string | "" | no |
| event_rw | Indicates whether the event is a read or a write event. Valid values: Read, Write, and All | string | Write | no |
| oss_key_prefix | The prefix of the specified OSS bucket name | string | "" | no |

## Outputs

| Name | Description |
|------|-------------|
| this_actiontrail_id | The actiontrail ID |
| this_oss_bucket_id | The OSS bucket id used to launch actiontrail |
| this_log_project_id | The log project id used to launch actiontrail |

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

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)