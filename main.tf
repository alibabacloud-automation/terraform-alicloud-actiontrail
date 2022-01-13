data "alicloud_ram_roles" "default" {
  name_regex = "^${var.ram_role_default_name}$"
}

resource "alicloud_ram_role" "this" {
  count       = var.create_actiontrail_default_role ? 1 : 0
  name        = var.ram_role_default_name
  document    = file(join("", [var.ram_role_default_name, ".json"]))
  description = "ActionTrail uses this ram role to access other resources."
  force       = "true"
}

resource "alicloud_ram_policy" "this" {
  count       = var.create_actiontrail_default_role ? 1 : 0
  name        = var.ram_policy_default_name
  document    = file(join("", [var.ram_policy_default_name, ".json"]))
  description = "A default ram policy used to ActionTrail default grant policy"
  force       = true
}

resource "alicloud_ram_role_policy_attachment" "this" {
  count       = var.create_actiontrail_default_role ? 1 : 0
  policy_name = join("", alicloud_ram_policy.this.*.name)
  role_name   = join("", alicloud_ram_role.this.*.name)
  policy_type = join("", alicloud_ram_policy.this.*.type)
}

resource "alicloud_oss_bucket" "this" {
  count         = var.create_oss_bucket ? 1 : 0
  bucket        = var.oss_bucket_name
  force_destroy = true
}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_account" "default" {
}

resource "alicloud_log_project" "this" {
  count       = var.log_project_arn != "" ? 0 : var.log_project_name == "" ? 0 : 1
  name        = var.log_project_name
  description = "a new log project used to launch actiontrail"
}

resource "alicloud_actiontrail" "this" {
  name            = var.this_module_name
  event_rw        = var.event_rw
  oss_bucket_name = var.create_oss_bucket ? join("", alicloud_oss_bucket.this.*.id) : var.oss_bucket_name
  role_name       = var.ram_role_default_name
  oss_key_prefix  = var.oss_key_prefix
  sls_project_arn = var.log_project_arn != "" ? var.log_project_arn : var.log_project_name == "" ? "" : join(
    "/",
    [
      join(
        ":",
        [
          "acs:log",
          data.alicloud_regions.default.regions[0].id,
          data.alicloud_account.default.id,
          "project",
        ],
      ),
      join("", alicloud_log_project.this.*.name),
    ],
  )
  sls_write_role_arn = var.log_project_arn == "" && var.log_project_name == "" ? "" : length(data.alicloud_ram_roles.default.roles) > 0 ? data.alicloud_ram_roles.default.roles[0].arn : join("", alicloud_ram_role.this.*.arn)
}

