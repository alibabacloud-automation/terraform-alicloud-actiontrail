output "this_ram_role_name" {
  description = "The RAM role name used to launch actiontrail"
  value       = concat(alicloud_ram_role.this[*].name, [""])[0]
}

output "this_ram_role_arn" {
  description = "The RAM role arn used to launch actiontrail"
  value       = concat(alicloud_ram_role.this[*].arn, [""])[0]
}

output "this_oss_bucket_name" {
  description = "The OSS bucket id used to launch actiontrail"
  value       = concat(alicloud_oss_bucket.this[*].id, [""])[0]
}

output "this_log_project_id" {
  description = "The log project id used to launch actiontrail"
  value       = join("", alicloud_log_project.this[*].id)
}

output "this_log_project_name" {
  description = "The log project name used to launch actiontrail"
  value       = concat(alicloud_log_project.this[*].naproject_nameme, [""])[0]
}

output "this_actiontrail_id" {
  description = "The actiontrail ID"
  value       = concat(alicloud_actiontrail_trail.this[*].id, [""])[0]
}

output "this_actiontrail_name" {
  description = "The actiontrail name"
  value       = concat(alicloud_actiontrail_trail.this[*].trail_name, [""])[0]
}

output "this_log_project_arn" {
  description = "The log project arn"
  value       = concat(alicloud_actiontrail_trail.this[*].sls_project_arn, [""])[0]
}

output "this_event_rw" {
  description = "The event rw"
  value       = concat(alicloud_actiontrail_trail.this[*].event_rw, [""])[0]
}

output "this_oss_key_prefix" {
  description = "The oss key prefix"
  value       = concat(alicloud_actiontrail_trail.this[*].oss_key_prefix, [""])[0]
}