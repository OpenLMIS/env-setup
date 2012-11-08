# Class: httpd::install
# just confirms presence of latest available apache-httpd package


class httpd::install {

  package { 'httpd' :
    ensure => 'latest',
  }
}
