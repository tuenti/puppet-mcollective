# private class
class mcollective_legacy::common::config::connector::rabbitmq {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::common::setting { 'direct_addressing':
    value => 1,
  }

  mcollective_legacy::common::setting { 'plugin.rabbitmq.vhost':
    value => $mcollective_legacy::rabbitmq_vhost,
  }

  mcollective_legacy::common::setting { 'plugin.rabbitmq.randomize':
    value => true,
  }

  $pool_size = size(flatten([$mcollective_legacy::middleware_hosts]))
  mcollective_legacy::common::setting { 'plugin.rabbitmq.pool.size':
    value => $pool_size,
  }

  $indexes = mco_array_to_string(range('1', $pool_size))
  mcollective_legacy::common::config::connector::rabbitmq::hosts_iteration { $indexes: }

  mcollective_legacy::common::setting { 'plugin.rabbitmq.heartbeat_interval':
    value => $mcollective_legacy::middleware_heartbeat_interval,
  }

}
