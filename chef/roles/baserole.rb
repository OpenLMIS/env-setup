name "baserole"
description "Installs basic packages for OpenLMIS"
run_list  "recipe[git]", "recipe[sun_jdk]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]", "role[nagios_nrpe]"
