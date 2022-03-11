variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

#alicloud_ram_role
variable "create_actiontrail_default_role" {
  description = "Create a default ram role used to access OSS and SLS before launching a new CreateTrail. Default using the existed ram role."
  type        = bool
  default     = false
}

variable "ram_role_default_name" {
  description = "A default ram role used to grant ActionTrail to access OSS and SLS. It is valid when create_actiontrail_default_role is true."
  type        = string
  default     = ""
}

variable "role_document" {
  description = "Authorization strategy of the RAM role."
  type        = string
  default     = ""
}

variable "ram_role_description" {
  description = "Description of the RAM role."
  type        = string
  default     = ""
}

variable "ram_role_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = true
}

#alicloud_ram_policy
variable "ram_policy_default_name" {
  description = "A default ram policy used to ActionTrail default grant policy. It is valid when create_actiontrail_default_role is true."
  type        = string
  default     = ""
}

variable "policy_document" {
  description = "Document of the RAM policy."
  type        = string
  default     = ""
}

variable "ram_policy_description" {
  description = "Description of the RAM policy."
  type        = string
  default     = ""
}

variable "ram_policy_force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = true
}

#alicloud_oss_bucket
variable "create_oss_bucket" {
  description = "Whether to create a new OSS bucket based on variable oss_bucket_name."
  type        = bool
  default     = false
}

variable "oss_bucket_name" {
  description = "A name of OSS bucket used to the trail delivers logs."
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = bool
  default     = true
}

#alicloud_log_project
variable "create_log_project" {
  description = "Whether to create a new log project."
  type        = bool
  default     = false
}

variable "log_project_name" {
  description = "A name used to create a new log project when log_project_arn is not set."
  type        = string
  default     = ""
}

variable "log_project_description" {
  description = "Description of the log project."
  type        = string
  default     = ""
}

#alicloud_actiontrail
variable "create_actiontrail_trail" {
  description = "Whether to create a new actiontrail trail."
  type        = bool
  default     = false
}

variable "this_module_name" {
  description = "Name used on ActionTrail"
  type        = string
  default     = ""
}

variable "event_rw" {
  description = "Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default value: Write."
  type        = string
  default     = "Write"
}

variable "oss_key_prefix" {
  description = "The prefix of the specified OSS bucket name. Default to empty."
  type        = string
  default     = ""
}

variable "log_project_arn" {
  description = "The unique ARN of the Log Service project used to the trail."
  type        = string
  default     = ""
}

variable "sls_write_role_arn" {
  description = "The unique ARN of the Log Service role."
  type        = string
  default     = ""
}