#
# Cookbook Name:: logrotate
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
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
