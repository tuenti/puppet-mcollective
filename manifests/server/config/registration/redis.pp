#
class mcollective_legacy::server::config::registration::redis {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::server::setting { 'registerinterval':
    value => 10,
  }

  mcollective_legacy::server::setting { 'registration':
    value => 'redis',
  }

  mcollective_legacy::plugin { 'registration/redis': }
}
