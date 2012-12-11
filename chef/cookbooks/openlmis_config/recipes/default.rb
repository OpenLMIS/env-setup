#
# Cookbook Name:: openlmis_config
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

directory "/home/openlmis/.ssh" do
  owner "openlmis"
  group "openlmis"
  mode "0700"
end

cookbook_file "/home/openlmis/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "openlmis"
  group "openlmis"
  mode "0600"
end

cookbook_file "/home/openlmis/.ssh/config" do
  source "config"
  owner "openlmis"
  group "openlmis"
  mode "0644"
end

template "/etc/profile.d/openlmis.sh" do
  source "openlmis.sh.erb"
  owner "openlmis"
  group "openlmis"
  mode "0644"
end
