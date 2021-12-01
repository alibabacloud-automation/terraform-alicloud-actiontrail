output "this_actiontrail_id" {
  description = "The actiontrail ID"
  value       = alicloud_actiontrail.this.id
}

output "this_module_name" {
  value = alicloud_actiontrail.this.name
}

output "this_oss_bucket_name" {
  description = "The OSS bucket id used to launch actiontrail"
  value       = alicloud_actiontrail.this.oss_bucket_name
}

output "this_log_project_id" {
  description = "The log project id used to launch actiontrail"
  value       = join("", alicloud_log_project.this.*.id)
}

output "this_log_project_arn" {
  value = alicloud_actiontrail.this.sls_project_arn
}

output "this_log_project_name" {
  value = concat(alicloud_log_project.this.*.name, [[]])[0]
}

output "this_event_rw" {
  value = alicloud_actiontrail.this.event_rw
}

output "this_oss_key_prefix" {
  value = alicloud_actiontrail.this.oss_key_prefix
}