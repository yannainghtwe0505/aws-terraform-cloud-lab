output "roles" {
  value = { for name, access in module.deployment_access : name => {
    plan_role_arn  = access.plan_role_arn
    apply_role_arn = access.apply_role_arn
  } }
}
