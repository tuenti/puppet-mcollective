# private class
class mcollective_legacy::client::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $mcollective_legacy::securityprovider == 'ssl' or $mcollective_legacy::securityprovider == 'sshkey' {
    # if using the ssl or sshkey securityprovider  each user will want their own ~/.mcollective
    # with their own identity in, so don't publish the global client.cfg
    file { 'mcollective_legacy::client':
      ensure => 'absent',
      path   => $mcollective_legacy::client_config_file_real,
    }
  }
  else {
    datacat { 'mcollective_legacy::client':
      owner    => 'root',
      group    => '0',
      mode     => '0444',
      path     => $mcollective_legacy::client_config_file_real,
      template => 'mcollective_legacy/settings.cfg.erb',
    }
  }

  mcollective_legacy::client::setting { 'loglevel':
    value => $mcollective_legacy::client_loglevel,
  }

  mcollective_legacy::client::setting { 'logger_type':
    value => $mcollective_legacy::client_logger_type,
  }

  mcollective_legacy::soft_include { [
    "::mcollective_legacy::client::config::connector::${mcollective_legacy::connector}",
    "::mcollective_legacy::client::config::securityprovider::${mcollective_legacy::securityprovider}",
  ]:
    start => Anchor['mcollective_legacy::client::config::begin'],
    end   => Anchor['mcollective_legacy::client::config::end'],
  }

  anchor { 'mcollective_legacy::client::config::begin': }
  anchor { 'mcollective_legacy::client::config::end': }
}
