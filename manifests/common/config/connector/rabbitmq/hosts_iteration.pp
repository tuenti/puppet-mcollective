# private define
# $name will be an index into the $mcollective::middleware_hosts array + 1
define mcollective_legacy::common::config::connector::rabbitmq::hosts_iteration {
  mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.host":
    value => $mcollective_legacy::middleware_hosts[$name - 1], # puppet array 0-based
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

  mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.port":
    value => $port,
  }

  mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.user":
    value => $mcollective_legacy::middleware_user,
  }

  mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.password":
    value => $mcollective_legacy::middleware_password,
  }

  if $middleware_ssl {
    mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.ssl":
      value => 1,
    }

    mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.ssl.ca":
      value => $::mcollective_legacy::middleware_ssl_ca_path,
    }

    mcollective_legacy::common::setting { "plugin.rabbitmq.pool.${name}.ssl.fallback":
      value => $fallback,
    }
  }
}
