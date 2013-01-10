# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2011
#
# All rights reserved - Do Not Redistribute

package "httpd" do
  package_name "httpd"
  action :install
end

service "httpd" do
  service_name "httpd"
  restart_command "/sbin/service httpd restart && sleep 1"
  reload_command "/sbin/service httpd reload && sleep 1"    

  action [:enable, :start]
end

