name "baserole"
description "Installs basic packages for OpenLMIS"
default_attributes(
                   "nagios" => {
                     "server_ip" => "192.168.34.5"}
                  )
run_list  "recipe[git]", "recipe[selinux::non_persistent_disable]", "recipe[sun_jdk]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]", "recipe[nagios_nrpe]"
