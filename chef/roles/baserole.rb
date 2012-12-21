name "baserole"
description "Installs basic packages for OpenLMIS"
run_list  "recipe[iptables]","recipe[git]", "recipe[java]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]", "role[nagios_nrpe]", "recipe[openlmis_config]", "recipe[jenkins-build-slave]"
