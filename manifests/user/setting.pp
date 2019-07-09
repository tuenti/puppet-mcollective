# Define - mcollective::user::setting
define mcollective_legacy::user::setting($username, $setting, $value, $order = '70') {
  mcollective_legacy::setting { "mcollective_legacy::user::setting ${title}":
    setting => $setting,
    value   => $value,
    target  => "mcollective_legacy::user ${username}",
    order   => $order,
  }
}
