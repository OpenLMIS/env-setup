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

directory "/etc/httpd/conf.d/ssl" do
  owner "root"
  group "root"
  action :create
end

cookbook_file "/etc/httpd/conf.d/ssl/apache_openlmis.key" do
  source "apache_openlmis.key"
  owner "root"
  group "root"
  mode "0600"	
end

cookbook_file "/etc/httpd/conf.d/ssl/apache_openlmis.crt" do
  source "apache_openlmis.crt"
  owner "root"
  group "root"
  mode "0600"	
end

yum_package "mod_ssl" do
  action :install
  flush_cache [:before]
end

service "httpd" do
  service_name "httpd"
  restart_command "/sbin/service httpd restart && sleep 1"
  reload_command "/sbin/service httpd reload && sleep 1"    

  action [:enable, :start]
end

