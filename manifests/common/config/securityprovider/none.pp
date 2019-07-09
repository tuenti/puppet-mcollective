# Private class
class mcollective_legacy::common::config::securityprovider::none {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::plugin { 'securityprovider/none': }
}
