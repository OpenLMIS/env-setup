####### user #######
$motechUser = 'openlmis'

####### deploy environment #######
$env = '<environment>'

####### httpd configuration begin #######
####### httpd configuration end #######

#Tomcat 7.0.22 configuration

class { 'repos': }
# to generate password hash use 'echo 'password' | openssl passwd -1 -stdin'
-> class { 'users' :
  userName => $motechUser,
  password => '$1$DzM5.Zej$sPBWAYiWiVVdDRcSu0Xt70'
  }
-> class { 'git' : }
-> class { 'tomcat' :
  version               => '7.0.22',
  userName              => $motechUser,
  tomcatManagerUserName => 'tomcat',
  tomcatManagerPassword => 'p@ssw0rd',}
-> class { 'postgres' :
  postgresUser      => 'postgres',
  postgresPassword  => '$1$DzM5.Zej$sPBWAYiWiVVdDRcSu0Xt70',
  postgresMachine   => 'master',
  postgresMaster    => '127.0.0.1',
  postgresSlave     => '127.0.0.1',
  os                => 'centos6',
  wordsize          => '32b',}
