# private class
class mcollective_legacy::server::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  datacat { 'mcollective_legacy::server':
    owner    => 'root',
    group    => '0',
    mode     => '0400',
    path     => $mcollective_legacy::server_config_file_real,
    template => 'mcollective_legacy/settings.cfg.erb',
  }

  mcollective_legacy::server::setting { 'classesfile':
    value => $mcollective_legacy::classesfile,
  }

  mcollective_legacy::server::setting { 'daemonize':
    value => bool2num($::mcollective_legacy::server_daemonize),
  }

  mcollective_legacy::server::setting { 'logfile':
    value => $mcollective_legacy::server_logfile,
  }

  mcollective_legacy::server::setting { 'loglevel':
    value => $mcollective_legacy::server_loglevel,
  }

  file { "${mcollective_legacy::confdir}/policies":
    ensure => 'directory',
    owner  => 'root',
    group  => '0',
    mode   => '0700',
  }

  file { $mcollective_legacy::ssldir:
    ensure => 'directory',
    owner  => 'root',
    group  => '0',
    mode   => '0755',
  }

  if $::mcollective_legacy::middleware_ssl {

    file { $::mcollective_legacy::middleware_ssl_ca_path:
      owner  => 'root',
      group  => '0',
      mode   => '0444',
      source => $::mcollective_legacy::middleware_ssl_ca_real,
    }

    file { $::mcollective_legacy::middleware_ssl_key_path:
      owner  => 'root',
      group  => '0',
      mode   => '0400',
      source => $::mcollective_legacy::middleware_ssl_key_real,
    }

    file { $::mcollective_legacy::middleware_ssl_cert_path:
      owner  => 'root',
      group  => '0',
      mode   => '0444',
      source => $::mcollective_legacy::middleware_ssl_cert_real,
    }

  }

  if $::mcollective_legacy::securityprovider == 'ssl' {

    file { $::mcollective_legacy::ssl_server_public_path:
      owner  => 'root',
      group  => '0',
      mode   => '0444',
      source => $::mcollective_legacy::ssl_server_public,
    }

    file { $::mcollective_legacy::ssl_server_private_path:
      owner  => 'root',
      group  => '0',
      mode   => '0400',
      source => $::mcollective_legacy::ssl_server_private,
    }

  }

  $middleware_multiple_ports = str2bool($mcollective_legacy::middleware_multiple_ports)

  if $middleware_multiple_ports {
    $pool_host_size = size(flatten([$mcollective_legacy::middleware_hosts]))
    $pool_port_size = $mcollective_legacy::middleware_ssl ? {
      true    => size(flatten([$mcollective_legacy::middleware_ssl_ports])),
      default => size(flatten([$mcollective_legacy::middleware_ports])),
    }

    if $pool_port_size != $pool_host_size {
      fail('Hosts and ports list must have the same length')
    }
  }

  mcollective_legacy::soft_include { [
    "::mcollective_legacy::server::config::connector::${mcollective_legacy::connector}",
    "::mcollective_legacy::server::config::securityprovider::${mcollective_legacy::securityprovider}",
    "::mcollective_legacy::server::config::factsource::${mcollective_legacy::factsource}",
    "::mcollective_legacy::server::config::registration::${mcollective_legacy::registration}",
    "::mcollective_legacy::server::config::rpcauditprovider::${mcollective_legacy::rpcauditprovider}",
    "::mcollective_legacy::server::config::rpcauthprovider::${mcollective_legacy::rpcauthprovider}",
  ]:
    start => Anchor['mcollective_legacy::server::config::begin'],
    end   => Anchor['mcollective_legacy::server::config::end'],
  }

  anchor { 'mcollective_legacy::server::config::begin': }
  anchor { 'mcollective_legacy::server::config::end': }
}
