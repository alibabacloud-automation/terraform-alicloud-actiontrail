#alicloud_ram_role
role_document        = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
                "ecs.aliyuncs.com",
                "actiontrail.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
ram_role_description = "update-tf-testacc-role-description"
ram_role_force       = true

#alicloud_ram_policy
policy_document  = <<EOF
  {
    "Statement": [
  {
      "Action": [
        "oss:ListObjects",
        "oss:PutObject",
        "oss:GetBucketLocation"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
    ],
      "Version": "1"
  }
  EOF
ram_policy_force = true

#alicloud_oss_bucket
force_destroy = true

#alicloud_log_project
log_project_description = "update-tf-testacc-log-description"

#alicloud_actiontrail
event_rw = "Write"