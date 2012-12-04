#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sun_jdk"

directory "/usr/tomcat" do
  owner "root"
  group "root"
  mode "775"
  action :create
end

cookbook_file "/tmp/apache-tomcat-7.0.33.tar.gz" do
  source "apache-tomcat-7.0.33.tar.gz"
  mode "0775"
  notifies :run, "execute[Installing Tomcat tarball]", :immediately
end

execute "Installing Tomcat tarball" do
  command "tar -xvf /tmp/apache-tomcat-7.0.33.tar.gz --directory=/usr/tomcat"
  action :nothing
end
