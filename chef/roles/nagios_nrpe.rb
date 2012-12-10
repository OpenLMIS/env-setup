name "nagios_nrpe"
description "Installs and configures nrpe for OpenLMIS Monitoring system"
default_attributes(
                   "nagios" => {
                     "server_ip" => "192.168.34.5"}
                  )
run_list  "recipe[chef-client]","recipe[nagios_nrpe]", "recipe[htop]"
