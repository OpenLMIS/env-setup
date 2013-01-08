#
# Cookbook Name:: logrotate
# Recipe:: centos
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#
package "logrotate" do
	action :install
end

cron "logrotate" do
	command "/usr/sbin/logrotate -v /etc/logrotate.d/openlmis"
	day "1"
end

template "/etc/logrotate.d/openlmis" do
	source "openlmis.erb"
	mode "0644"
	owner "root"
	group "root"
end
