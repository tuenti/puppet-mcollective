# private class
class mcollective_legacy::server::config::connector::activemq {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # Oh puppet!  Fake iteration of the indexes (+1 as plugin.activemq.pool is
  # 1-based)
  $pool_size = size(flatten([$mcollective_legacy::middleware_hosts]))
  $indexes = mco_array_to_string(range('1', $pool_size))
  mcollective_legacy::server::config::connector::activemq::hosts_iteration { $indexes: }
}
