# private define
# $name will be an index into the $mcollective::middleware_hostsarray + 1
define mcollective_legacy::common::config::connector::activemq::hosts_iteration {
  $middleware_hosts_array = flatten([$mcollective_legacy::middleware_hosts])
  mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.host":
    value => $middleware_hosts_array[$name - 1],
  }

  $middleware_ssl = str2bool($mcollective_legacy::middleware_ssl)
  $middleware_multiple_ports = str2bool($mcollective_legacy::middleware_multiple_ports)

  $port = $middleware_multiple_ports ? {
    true    => $middleware_ssl ? {
      true    => $mcollective_legacy::middleware_ssl_ports[$name - 1],
      default => $mcollective_legacy::middleware_ports[$name - 1],
    },
    default => $middleware_ssl ? {
      true    => $mcollective_legacy::middleware_ssl_port,
      default => $mcollective_legacy::middleware_port,
    }
  }

  $fallback = $mcollective_legacy::middleware_ssl_fallback ? {
    true    => 1,
    default => 0,
  }

  mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.port":
    value => $port,
  }

  mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.user":
    value => $mcollective_legacy::middleware_user,
  }

  mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.password":
    value => $mcollective_legacy::middleware_password,
  }

  if $middleware_ssl {
    mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.ssl":
      value => 1,
    }

    mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.ssl.cert":
      value => '/etc/mcollective/server_public.pem',
    }

    mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.ssl.key":
      value => '/etc/mcollective/server_private.pem',
    }

    mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.ssl.ca":
      value => $::mcollective_legacy::middleware_ssl_ca_path,
    }

    mcollective_legacy::common::setting { "plugin.activemq.pool.${name}.ssl.fallback":
      value => $fallback,
    }
  }
}
