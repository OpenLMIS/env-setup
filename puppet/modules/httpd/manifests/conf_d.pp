# Class: httpd::conf_d
# to provide baisc apache httpd configuration

define httpd::conf_d($template_name) {

  $config_path = '/etc/httpd/conf.d'

  file { "${config_path}/${name}.conf":
    content      => template($template_name),
    notify       => Service['httpd'],
  }
}

