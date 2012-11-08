# Class: httpd::service
# to provide baisc apache httpd configuration

class httpd::service {

    service {'httpd' :
        ensure     => 'running',
        enable     => true,
        hasrestart => true,
        require    => Package['httpd'],
    }
}
