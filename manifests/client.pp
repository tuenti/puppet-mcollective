# private class
# Installs the client and sets up /etc/mcollective/client.cfg (global/common
# configuration)
class mcollective_legacy::client {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  contain ::mcollective_legacy::client::install
  contain ::mcollective_legacy::client::config

  Class['mcollective_legacy::client::install']
  -> Class['mcollective_legacy::client::config']
}
