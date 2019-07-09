# private class
class mcollective_legacy::server::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $mcollective_legacy::manage_packages {
    package { $mcollective_legacy::server_package:
      ensure => $mcollective_legacy::version,
    }

    if $::osfamily == 'Debian' {
      # XXX the dependencies my test ubuntu 12.04 system seem to not correctly
      # state ruby-stomp as a dependency of mcollective, so hand specify
      package { $mcollective_legacy::ruby_stomp_package:
        ensure => $mcollective_legacy::ruby_stomp_ensure,
        before => Package[$mcollective_legacy::server_package],
      }
    }
  }
}
