# private class
class mcollective_legacy::server::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $mcollective_legacy::service_name:
    ensure => $mcollective_legacy::service_ensure,
    enable => $mcollective_legacy::service_enable,
  }
}
