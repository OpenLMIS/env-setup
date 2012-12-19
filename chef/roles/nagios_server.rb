name "nagios_server"
description "Setup of nagios server"
run_list "recipe[git]","recipe[htop]","recipe[chef-client]","recipe[nagios_nrpe]","recipe[nagios_server]"
default_attributes(
                   "nagios" => {
                     "server_ip" => "192.168.34.5",
                     "admins" => {"nagiosadmin" => "n@g!0s@dm!n"},
                     "guests" => {"guest" => "guest", "openlmis" => "openlmis"}},
                   "chef" => {
                    "server_url" => "http://192.168.34.5:4000"
                    }
                  )
