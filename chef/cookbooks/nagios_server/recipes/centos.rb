# Cookbook Name:: nagios_server
# Recipe:: centos 
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

include_recipe "httpd"

%w{nagios php nagios-plugins-all pnp4nagios}.each do |pkg|
  package pkg 
end

service "httpd" do
  supports :restart => true
  action [:enable, :start]
end

file "/etc/nagios/passwd" do
  owner "nagios"
  group "nagios"
  action :create_if_missing
end

execute "update the passwords file for admins" do
  cmd = node["nagios"]["admins"].collect do |user, passwd|
    "/usr/bin/htpasswd -b /etc/nagios/passwd #{user} #{passwd}"
  end.join(" && ")

  command cmd
  notifies :restart, "service[httpd]", :immediately
end

execute "update the passwords file for guests" do
  cmd = node["nagios"]["guests"].collect do |user, passwd|
    "/usr/bin/htpasswd -b /etc/nagios/passwd #{user} #{passwd}"
  end.join(" && ")

  command cmd
  notifies :restart, "service[httpd]", :immediately
end

execute "Changing permissions for client.pem in /etc/chef/ for nagios access" do
  command "chmod 644 /etc/chef/client.pem"
end

cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0755"
end

if Chef::Config[:solo]
  Chef::Log.error("This Nagios cookbook cannot run with Chef Solo as it depends on Search.")
  nodes_from_solr = []
else
  nodes_from_solr = search(:node, "*:*")
  CI_servers = search(:node, "chef_environment:CI")
  QA_servers = search(:node, "chef_environment:QA")
  UAT_servers = search(:node, "chef_environment:UAT")
end

["templates","hosts", "services", "commands", "localhost"].each do |obj|
  template "/etc/nagios/objects/#{obj}.cfg" do
    source "#{obj}.cfg.erb"
    owner "root"
    group "root"
    mode "644"
    variables(:nodes_from_solr => nodes_from_solr, :CI_servers => CI_servers, :QA_servers => QA_servers, :UAT_servers => UAT_servers)
    notifies :restart, "service[nrpe]", :immediately
    notifies :restart, "service[nagios]", :immediately
  end
end

execute "nagios-config-check" do
  command "nagios -v /etc/nagios/nagios.cfg"
end

service "nrpe" do
  supports :restart => true
  action [:enable, :start]
  
  start_command "/usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d"
  stop_command "service nrpe stop"
  restart_command "service nrpe stop; /usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d"
end

service "nagios" do
  supports :restart => true
  action [:enable, :start]
  
  start_command "/usr/sbin/nagios -d /etc/nagios/nagios.cfg"
  stop_command "service nagios stop"
  restart_command "service nagios stop; /usr/sbin/nagios -d /etc/nagios/nagios.cfg"
end

