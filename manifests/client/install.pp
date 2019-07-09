# private class
class mcollective_legacy::client::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $mcollective_legacy::manage_packages {
    # prevent conflict where client package name == server package name
    if $mcollective_legacy::client_package != $mcollective_legacy::server_package {
      package { $mcollective_legacy::client_package:
        ensure => $mcollective_legacy::version,
      }
    }
  }
}
