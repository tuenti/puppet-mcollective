# Define - mcollective::actionpolicy
# Sets up the actionpolicy for an agent
# Install them with mcollective::plugin
# Namevar will be the name of the agent to configure
define mcollective_legacy::actionpolicy($default = 'deny') {

  include ::mcollective_legacy

  datacat { "mcollective_legacy::actionpolicy ${name}":
    owner    => 'root',
    group    => '0',
    mode     => '0400',
    path     => "${mcollective_legacy::confdir}/policies/${name}.policy",
    template => 'mcollective_legacy/actionpolicy.erb',
  }

  datacat_fragment { "mcollective_legacy::actionpolicy ${name} actionpolicy default":
    target => "mcollective_legacy::actionpolicy ${name}",
    data   => {
      'default' => $default,
    },
  }
}
