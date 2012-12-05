#
# Cookbook Name:: nagios_server
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
include_recipe "httpd"

%w{nagios php nagios-plugins-all pnp4nagios}.each do |pkg|
  package pkg 
end

["nagios", "httpd"].each do |svc|
  service svc do
    supports :restart => true
    action [:enable, :start]
  end
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
  notifies :restart, resources(:service => 'httpd') 
end

execute "update the passwords file for guests" do
  cmd = node["nagios"]["guests"].collect do |user, passwd|
    "/usr/bin/htpasswd -b /etc/nagios/passwd #{user} #{passwd}"
  end.join(" && ")

  command cmd
  notifies :restart, resources(:service => 'httpd') 
end

execute "Changing permissions for client.pem in /etc/chef/ for nagios access" do
  command "chmod 644 /etc/chef/client.pem"
end

cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0755"
end

nodes_from_solr = search(:node, "*:*")

["hosts", "services", "commands", "localhost"].each do |obj|
  template "/etc/nagios/objects/#{obj}.cfg" do
    source "#{obj}.cfg.erb"
    owner "root"
    group "root"
    mode "644"
    variables(:nodes_from_solr => nodes_from_solr)
    notifies :restart, "service[nrpe]"
  end
end

execute "nagios-config-check" do
  command "nagios -v /etc/nagios/nagios.cfg"
end



