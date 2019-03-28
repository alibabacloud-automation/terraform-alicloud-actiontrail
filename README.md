Terraform module which creates ActionTrail on Alibaba Cloud
terraform-alicloud-actiontrail
====================================================================

Terraform module which creates a new action trail on Alibaba Cloud.

These types of resources are supported:

* [ActionTrail](https://www.terraform.io/docs/providers/alicloud/r/actiontrail.html)

----------------------

Usage
-----
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
-> NOTE: If the ram role has been created, please ignore it and the module will fetch the existed and grant to the new ationtrail.

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

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)


