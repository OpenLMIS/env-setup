# Class: httpd::params
# to provide module specific (non-environment affected) values

class httpd::params {
  $sslCertificateFile     = '/etc/pki/tls/certs/localhost.crt'
  $sslCertificateKeyFile  = '/etc/pki/tls/private/localhost.key'
}
