# private define
# $name will be an index into the $mcollective::middleware_hosts array + 1
define mcollective_legacy::server::config::connector::activemq::hosts_iteration {
  if $mcollective_legacy::middleware_ssl {
    mcollective_legacy::server::setting { "plugin.activemq.pool.${name}.ssl.cert":
      value => $::mcollective_legacy::middleware_ssl_cert_path,
    }

    mcollective_legacy::server::setting { "plugin.activemq.pool.${name}.ssl.key":
      value => $::mcollective_legacy::middleware_ssl_key_path,
    }

    if ! empty( $mcollective_legacy::ssl_ciphers ) {
      mcollective_legacy::server::setting { "plugin.activemq.pool.${name}.ssl.ciphers":
        value => $mcollective_legacy::ssl_ciphers,
      }
    }
  }
}
