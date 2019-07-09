# private define - mcollective::setting
define mcollective_legacy::setting($setting, $value, $target, $order = '50') {
  datacat_fragment { "mcollective_legacy::setting ${title}":
    target => $target,
    order  => $order,
    data   => hash([ $setting, $value ]),
  }
}
