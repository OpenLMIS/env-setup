# Class: repos::jenkins

class repos::postgres91 {

  file {
    '/etc/yum.repos.d/pgdg-91-centos.repo':
      ensure => 'present',
      source => 'puppet:///modules/repos/pgdg-91-centos.repo',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
  }

  file {
    '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-91':
      ensure => 'present',
      source => 'puppet:///modules/repos/RPM-GPG-KEY-PGDG-91',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
  }
}
