variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  default     = ""
}

variable "this_module_name" {
  description = "Name used on ActionTrail"
}

variable "oss_bucket_name" {
  description = "A name of OSS bucket used to the trail delivers logs."
}

variable "create_oss_bucket" {
  description = "Whether to create a new OSS bucket based on variable oss_bucket_name."
  default     = false
}

variable "create_actiontrail_default_role" {
  description = "Create a default ram role used to access OSS and SLS before launching a new CreateTrail. Default using the existed ram role."
  default     = false
}

variable "ram_role_default_name" {
  description = "A default ram role used to grant ActionTrail to access OSS and SLS. It is valid when create_actiontrail_default_role is true."
  default     = "AliyunActionTrailDefaultRole"
}

variable "ram_policy_default_name" {
  description = "A default ram policy used to ActionTrail default grant policy. It is valid when create_actiontrail_default_role is true."
  default     = "AliyunActionTrailRolePolicy"
}

variable "log_project_arn" {
  description = "The unique ARN of the Log Service project used to the trail."
  default     = ""
}

variable "log_project_name" {
  description = "A name used to create a new log project when log_project_arn is not set."
  default     = ""
}

variable "event_rw" {
  description = "Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default value: Write."
  default     = "Write"
}

variable "oss_key_prefix" {
  description = "The prefix of the specified OSS bucket name. Default to empty."
  default     = ""
}

