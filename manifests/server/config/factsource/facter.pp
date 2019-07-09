# private class
class mcollective_legacy::server::config::factsource::facter {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  mcollective_legacy::plugin { 'facter':
    type       => 'facts',
    package    => true,
    has_client => false,
  }

  mcollective_legacy::server::setting { 'factsource':
    value => 'facter',
  }

  mcollective_legacy::server::setting { 'fact_cache_time':
    value => 300,
  }
}
