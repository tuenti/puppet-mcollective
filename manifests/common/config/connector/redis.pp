# Private class
class mcollective_legacy::common::config::connector::redis {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::common::setting { 'direct_addressing':
    value => 'yes',
  }

  mcollective_legacy::common::setting { 'direct_addressing_threshold':
    value => 5,
  }

  # Redis connector only uses one host to connect to.  Assume that the first will
  # be OK
  mcollective_legacy::common::setting { 'plugin.redis.host':
    value => $mcollective_legacy::middleware_hosts[0],
  }

  mcollective_legacy::plugin { 'connector/redis': }

  package { 'rubygem-redis':
    ensure => installed,
  }
}
