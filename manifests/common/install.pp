# private class
class mcollective_legacy::common::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $mcollective_legacy::manage_packages {
    package { $mcollective_legacy::common_package:
      ensure => $mcollective_legacy::version,
    }
  }
}
