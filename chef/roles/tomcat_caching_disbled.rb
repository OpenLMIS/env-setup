name "tomcat_caching_disbled"
description "Disabling caching in tomcat"
run_list "recipe[tomcat]", "recipe[tomcat::disable_cache]"
