# Define - mcollective::actionpolicy::rule
define mcollective_legacy::actionpolicy::rule(
  String $agent,
  Enum['allow', 'deny'] $action = 'allow',
  String $callerid              = '*',
  String $actions               = '*',
  String $fact_filter           = '*',
  String $classes               = '*'
) {
  datacat_fragment { "mcollective_legacy::actionpolicy::rule ${title}":
    target => "mcollective_legacy::actionpolicy ${agent}",
    data   => {
      lines => [
        {
          'action'   => $action,
          'callerid' => $callerid,
          'actions'  => $actions,
          'facts'    => $fact_filter,
          'classes'  => $classes,
        },
      ],
    },
  }
}
