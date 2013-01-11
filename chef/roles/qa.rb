name "qa"
description "QA environment specific role"
run_list  "recipe[iptables]","recipe[openlmis_config]","recipe[git]", "recipe[java]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]", "role[nagios_nrpe]","recipe[logrotate]"
