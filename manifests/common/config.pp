#
class mcollective_legacy::common::config (
  $purge_libdir = true,
) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { $mcollective_legacy::site_libdir:
    ensure       => directory,
    owner        => 'root',
    group        => '0',
    mode         => '0644',
    recurse      => true,
    purge        => $purge_libdir,
    force        => true,
    source       => [],
    sourceselect => 'all',
  }

  if $mcollective_legacy::server {
    # if we have a server install, reload when the plugins change
    File[$mcollective_legacy::site_libdir] ~> Class['mcollective_legacy::server::service']
  }

  datacat_collector { 'mcollective_legacy::site_libdir':
    before          => File[$mcollective_legacy::site_libdir],
    target_resource => File[$mcollective_legacy::site_libdir],
    target_field    => 'source',
    source_key      => 'source_path',
  }

  datacat_fragment { 'mcollective_legacy::site_libdir':
    target => 'mcollective_legacy::site_libdir',
    data   => {
      source_path => [ 'puppet:///modules/mcollective_legacy/site_libdir' ],
    },
  }

  $libdir = $::mcollective_legacy::core_libdir ? {
    undef   => $::mcollective_legacy::site_libdir,
    ''      => $::mcollective_legacy::site_libdir,
    default => "${::mcollective_legacy::site_libdir}:${::mcollective_legacy::core_libdir}"
  }

  mcollective_legacy::common::setting { 'libdir':
    value => $libdir,
  }

  mcollective_legacy::common::setting { 'connector':
    value => $mcollective_legacy::connector,
  }

  mcollective_legacy::common::setting { 'securityprovider':
    value => $mcollective_legacy::securityprovider,
  }

  mcollective_legacy::common::setting { 'collectives':
    value => join(flatten([$mcollective_legacy::collectives]), ','),
  }

  mcollective_legacy::common::setting { 'main_collective':
    value => $mcollective_legacy::main_collective,
  }

  mcollective_legacy::common::setting { 'identity':
    value => $mcollective_legacy::identity,
  }


  mcollective_legacy::soft_include { [
    "::mcollective_legacy::common::config::connector::${mcollective_legacy::connector}",
    "::mcollective_legacy::common::config::securityprovider::${mcollective_legacy::securityprovider}",
  ]:
    start => Anchor['mcollective_legacy::common::config::begin'],
    end   => Anchor['mcollective_legacy::common::config::end'],
  }

  anchor { 'mcollective_legacy::common::config::begin': }
  anchor { 'mcollective_legacy::common::config::end': }
}
