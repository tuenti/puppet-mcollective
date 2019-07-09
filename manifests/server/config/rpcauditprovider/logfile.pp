# private class
class mcollective_legacy::server::config::rpcauditprovider::logfile {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::server::setting { 'rpcauditprovider':
    value => 'logfile',
  }

  mcollective_legacy::server::setting { 'rpcaudit':
    value => 1,
  }

  mcollective_legacy::server::setting { 'plugin.rpcaudit.logfile':
    value => $mcollective_legacy::rpcauditlogfile,
  }
}
