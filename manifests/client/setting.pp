# Define - mcollective::client::setting
define mcollective_legacy::client::setting (
  $value,
  $setting = $name,
  $order   = '30',
) {
  mcollective_legacy::setting { "mcollective_legacy::client::setting ${title}":
    setting => $setting,
    value   => $value,
    target  => [ 'mcollective_legacy::client', 'mcollective_legacy::user' ],
    order   => $order,
  }
}
