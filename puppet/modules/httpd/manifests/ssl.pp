# Class: httpd::ssl
#  to enable mod_ssl for apache

class httpd::ssl {

  include httpd::params

  $config_path            = '/etc/httpd/conf.d'
  $sslCertificateFile     = $httpd::sslCertificateFile
  $sslCertificateKeyFile  = $httpd::sslCertificateKeyFile

  package { 'mod_ssl' :
    ensure      =>  'present',
    require     => File['/etc/httpd/conf/httpd.conf'],
  }

  exec { 'ssl_conf_backup' :
    cwd         => $config_path,
    command     => 'mv ssl.conf ssl.conf.lmis',
    require     => Package['mod_ssl'],
    unless      => "ls ${config_path}/ssl.conf.lmis",
  }

  file { "${config_path}/ssl.conf":
    content      => template('httpd/ssl.conf.erb'),
    require      => Exec['ssl_conf_backup'],
    notify       => Service['httpd'],
  }
}
