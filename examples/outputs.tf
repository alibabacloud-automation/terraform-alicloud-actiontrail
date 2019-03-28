output "this_actiontrail_id" {
  description = "The actiontrail ID"
  value       = "${module.actiontrail.this_actiontrail_id}"
}

output "this_oss_bucket_id" {
  description = "The OSS bucket id used to launch actiontrail"
  value       = "${module.actiontrail.this_oss_bucket_id}"
}

output "this_log_project_id" {
  description = "The log project id used to launch actiontrail"
  value       = "${module.actiontrail.this_log_project_id}"
}
