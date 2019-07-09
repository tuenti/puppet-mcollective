# private class
class mcollective_legacy::common::config::connector::activemq {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::common::setting { 'direct_addressing':
    value => 1,
  }

  mcollective_legacy::common::setting { 'plugin.activemq.base64':
    value => yes,
  }

  mcollective_legacy::common::setting { 'plugin.activemq.randomize':
    value => true,
  }

  $pool_size = size(flatten([$mcollective_legacy::middleware_hosts]))
  mcollective_legacy::common::setting { 'plugin.activemq.pool.size':
    value => $pool_size,
  }

  $indexes = mco_array_to_string(range('1', $pool_size))
  mcollective_legacy::common::config::connector::activemq::hosts_iteration { $indexes: }

  mcollective_legacy::common::setting { 'plugin.activemq.heartbeat_interval':
    value => $mcollective_legacy::middleware_heartbeat_interval,
  }

}
