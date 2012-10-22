####### user #######
$openlmisUser = "openlmis"

####### deploy environment #######
$env = "<environment>"

####### httpd configuration begin #######
####### httpd configuration end #######


class { "repos": }
# to generate password hash use 'echo "password" | openssl passwd -1 -stdin'
-> class { "users" :
	userName => "${openlmisUser}",
	password => "$1$DzM5.Zej$sPBWAYiWiVVdDRcSu0Xt70" }
-> class { "git" : }
-> class { "tomcat" :
	version => "7.0.22",
	userName => "${openlmisUser}"}
-> class { "postgres" :
	postgresUser => "postgres",
	postgresPassword => "$1$DzM5.Zej$sPBWAYiWiVVdDRcSu0Xt70",
	postgresMachine => "master",
	postgresMaster => "127.0.0.1",
	postgresSlave => "127.0.0.1",
	os => "centos6",
	wordsize => "32b",}
