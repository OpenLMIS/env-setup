name "baserole"
description "Installs basic packages for OpenLMIS"
run_list  "recipe[git]", "recipe[selinux::non_persistent_disable]", "recipe[sun_jdk]", "recipe[gradle]", "recipe[postgres]", "recipe[tomcat]"
