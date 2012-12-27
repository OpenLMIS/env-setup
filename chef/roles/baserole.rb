name "baserole"
description "Installs basic packages for OpenLMIS"
run_list  "recipe[iptables]","recipe[openlmis_config]","recipe[git]", "recipe[java]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]", "role[nagios_nrpe]"
