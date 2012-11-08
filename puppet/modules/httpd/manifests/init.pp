# Class: httpd
#
# To enable mod_ssl, need to separately include 'httpd::ssl' in node manifest
#
# Project specific rules should be added as separate using httpd::conf_d
# add a template to puppet/modules/httpd/template for whatever config required
# httpd::conf_d{'new_lmis':
#   template_name => 'httpd/new_lmis.conf.erb',
# }
#

class httpd{

  include httpd::install
  class{'httpd::config': }
  class{'httpd::service':
    require => Class['httpd::config'],
  }
}
