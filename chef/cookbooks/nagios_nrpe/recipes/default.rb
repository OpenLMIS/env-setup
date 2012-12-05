#
# Cookbook Name:: nagios_nrpe
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all"].each do |pkg|
  package pkg
end

template "/etc/nagios/nrpe.cfg" do
  source "nrpe.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[open port for nagios]", :immediately
end

template "/etc/nrpe.d/system.cfg" do
  source "system.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[nrpe]", :immediately
end

["check_inode", "check_memory", "check_space", "check_procs"].each do |file|
  cookbook_file "/usr/lib64/nagios/plugins/#{file}" do
    source file
    owner "root"
    group "root"
    mode "755"
    notifies :restart, "service[nrpe]", :immediately
  end
end

execute "open port for nagios" do
  command "iptables -I INPUT -p tcp -m tcp --dport 5666 -j ACCEPT"
  action :nothing
end

service "nrpe" do
  supports :restart => true
  action [:enable, :start]
end
