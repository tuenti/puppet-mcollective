# private class
class mcollective_legacy::common::config::securityprovider::psk {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::common::setting { 'plugin.psk':
    value => $mcollective_legacy::psk,
  }
}
