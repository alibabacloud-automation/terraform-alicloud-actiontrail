#alicloud_ram_role
variable "role_document" {
  description = "Authorization strategy of the RAM role."
  type        = string
  default     = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "actiontrail.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
  EOF
}

variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = "tf-testacc-role-description"
}

variable "ram_role_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

#alicloud_ram_policy
variable "policy_document" {
  description = "Document of the RAM policy."
  type        = string
  default     = <<EOF
{
    "Statement": [
        {
            "Action": [
                "oss:ListObjects",
                "oss:PutObject",
                "oss:GetBucketLocation",
                "kms:ListKeys",
                "kms:Listalias",
                "kms:ListAliasesByKeyId",
                "kms:DescribeKey",
                "kms:GenerateDataKey",
                "kms:Decrypt"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "log:GetProject"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "log:PostLogStoreLogs",
                "log:CreateLogstore",
                "log:GetLogstore",
                "log:CreateIndex",
                "log:UpdateIndex",
                "log:GetIndex",
                "log:GetLogStoreLogs"
            ],
            "Resource": [
                "acs:log:*:*:project/*/logstore/actiontrail_*",
                "acs:log:*:*:project/*/logstore/innertrail_*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "log:CreateDashboard",
                "log:UpdateDashboard"
            ],
            "Resource": "acs:log:*:*:project/*/dashboard/*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "log:CreateSavedSearch",
                "log:UpdateSavedSearch"
            ],
            "Resource": [
                "acs:log:*:*:project/*/savedsearch/actiontrail_*",
                "acs:log:*:*:project/*/savedsearch/innertrail_*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "mns:PublishMessage"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "resourcemanager:GetResourceDirectory",
                "resourcemanager:ListAccounts",
                "resourcemanager:GetResourceDirectoryAccount"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "cms:DescribeMetricList",
                "cms:QueryMetricList"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "ram:DeleteServiceLinkedRole",
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEquals": {
                    "ram:ServiceName": "actiontrail.aliyuncs.com"
                }
            }
        }
    ],
    "Version": "1"
}
  EOF
}

variable "ram_policy_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

#alicloud_oss_bucket
variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}

#alicloud_log_project
variable "log_project_description" {
  description = "Description of the log project."
  type        = string
  default     = "tf-testacc-log-description"
}

#alicloud_actiontrail
variable "event_rw" {
  description = "Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default value: Write."
  type        = string
  default     = "All"
}