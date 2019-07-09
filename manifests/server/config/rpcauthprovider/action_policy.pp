# private class
class mcollective_legacy::server::config::rpcauthprovider::action_policy {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::plugin { 'actionpolicy': }

  mcollective_legacy::server::setting { 'rpcauthorization':
    value => 1,
  }

  mcollective_legacy::server::setting { 'rpcauthprovider':
    value => 'action_policy',
  }

  mcollective_legacy::server::setting { 'plugin.actionpolicy.allow_unconfigured':
    value => $mcollective_legacy::allowunconfigured,
  }
}
