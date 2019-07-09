# private class
class mcollective_legacy::server {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  contain ::mcollective_legacy::server::install
  contain ::mcollective_legacy::server::config
  contain ::mcollective_legacy::server::service

  Class['mcollective_legacy::server::install']
  -> Class['mcollective_legacy::server::config']
  ~> Class['mcollective_legacy::server::service']
}
