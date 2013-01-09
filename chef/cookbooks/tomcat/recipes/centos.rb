# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

remote_file "#{node["webapp"]["home"]}/apache-tomcat-7.0.33.tar.gz" do
  source "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.33/bin/apache-tomcat-7.0.33.tar.gz"
  owner "openlmis"
  group "openlmis"
  mode "0775"
  notifies :run, "execute[Installing Tomcat tarball]", :immediately
end

execute "Installing Tomcat tarball" do
  command "tar -xvf /tmp/apache-tomcat-7.0.33.tar.gz --directory=#{node["webapp"]["home"]}; chown -R openlmis:openlmis #{node["webapp"]["home"]}/apache-tomcat-7.0.33"
  action :nothing
end

cookbook_file "/etc/init.d/tomcat" do
  source "tomcat"
  owner "root"
  group "root"
  mode "0755"
  notifies :run, "execute[Add tomcat to chkconfig]", :immediately
end

execute "Add tomcat to chkconfig" do
  command "chkconfig --add tomcat; chkconfig tomcat on"
  action :nothing
  notifies :start, "service[tomcat]", :immediately
end

service "tomcat" do
  supports :start => true, :stop => true, :restart => true
  action :start
end
