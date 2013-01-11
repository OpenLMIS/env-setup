name "uat"
description "UAT environment specific role"
run_list  "recipe[iptables]","recipe[openlmis_config]","recipe[git]", "recipe[java]", "recipe[gradle]", "recipe[postgres]", "role[tomcat_caching_disbled]", "role[nagios_nrpe]","recipe[logrotate]"
