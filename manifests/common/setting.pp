# Define - mcollective::common::setting
define mcollective_legacy::common::setting (
  $value,
  $setting = $name,
  $order = '10',
) {
  mcollective_legacy::setting { "mcollective_legacy::common::setting ${name}":
    setting => $setting,
    value   => $value,
    target  => [ 'mcollective_legacy::server', 'mcollective_legacy::client' ],
    order   => $order,
  }
}
