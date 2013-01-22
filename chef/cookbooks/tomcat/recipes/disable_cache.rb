# Cookbook Name:: tomcat
# Recipe:: disable_cache
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

execute "Disable Cache" do
  command " sed -i 's/<Context>/<Context cachingAllowed=\"false\">/g' #{node["tomcat"]["home"]}/conf/context.xml"
  action :run
  notifies :restart, "service[tomcat]", :immediately
  not_if "grep 'Context cachingAllowed=\"false\"' #{node["tomcat"]["home"]}/conf/context.xml"
end

service "tomcat" do
  supports :start => true, :stop => true, :restart => true
  action :nothing
end
