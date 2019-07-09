#
class mcollective_legacy::common {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  contain ::mcollective_legacy::common::install
  contain ::mcollective_legacy::common::config

  Class['mcollective_legacy::common::install']
  -> Class['mcollective_legacy::common::config']

}
