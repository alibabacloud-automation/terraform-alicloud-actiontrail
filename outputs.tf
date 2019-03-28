output "this_actiontrail_id" {
  description = "The actiontrail ID"
  value       = "${alicloud_actiontrail.this.id}"
}

output "this_oss_bucket_id" {
  description = "The OSS bucket id used to launch actiontrail"
  value       = "${alicloud_actiontrail.this.oss_bucket_name}"
}

output "this_log_project_id" {
  description = "The log project id used to launch actiontrail"
  value       = "${join("", alicloud_log_project.this.*.id)}"
}
