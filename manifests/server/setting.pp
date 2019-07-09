# Define - mcollective::server::setting
define mcollective_legacy::server::setting (
  $value,
  $setting = $name,
  $order   = '30',
) {
  mcollective_legacy::setting { "mcollective_legacy::server::setting ${title}":
    setting => $setting,
    value   => $value,
    target  => 'mcollective_legacy::server',
    order   => $order,
  }
}
