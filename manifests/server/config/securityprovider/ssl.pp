# private class
class mcollective_legacy::server::config::securityprovider::ssl {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { $::mcollective_legacy::ssl_client_certs_dir_real:
    ensure  => 'directory',
    owner   => 'root',
    group   => '0',
    purge   => true,
    recurse => true,
    mode    => '0400',
    source  => $::mcollective_legacy::ssl_client_certs,
  }

  mcollective_legacy::server::setting { 'plugin.ssl_client_cert_dir':
    value => $::mcollective_legacy::ssl_client_certs_dir_real,
  }

  mcollective_legacy::server::setting { 'plugin.ssl_server_public':
    value => $::mcollective_legacy::ssl_server_public_path,
  }

  mcollective_legacy::server::setting { 'plugin.ssl_server_private':
    value => $::mcollective_legacy::ssl_server_private_path,
  }
}
