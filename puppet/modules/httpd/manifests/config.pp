# Class: httpd::config
# to provide baisc apache httpd configuration

class httpd::config {

  $config_path            = '/etc/httpd/conf'

  exec { 'httpd_conf_backup' :
    cwd     => $config_path,
    command => 'mv httpd.conf httpd.conf.lmis',
    require => Package['httpd'],
    unless  => "ls ${config_path}/httpd.conf.lmis",
  }

  file { "${config_path}/httpd.conf":
    content      => template('httpd/httpd.conf.erb'),
    require      => Exec['httpd_conf_backup'],
    notify       => Service['httpd'],
  }
}
