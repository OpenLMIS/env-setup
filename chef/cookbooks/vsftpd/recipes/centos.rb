#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 
%w{vsftpd db4 db4-utils}.each do |package|
	yum_package "#{package}" do
		action :install
	end
end

cookbook_file "/etc/vsftpd/vsftpd.conf" do	
	source "vsftpd.conf"
	action :create
	mode 0600
	owner "root"
	group "root"
end

cookbook_file "/etc/vsftpd/vusers.txt" do
	source "virtual_users.txt"
	action :create
	mode 0600
	owner "root"
	group "root"
end

execute "create database file" do
	command "db_load -T -t hash -f vusers.txt vsftpd-virtual-user.db || cdmod 600 vsftpd-virtual-user.db || rm vusers.txt"
	cwd "/etc/vsftpd/"
end

cookbook_file "/etc/pam.d/vsftpd.virtual" do
	source "vsftpd.virtual"
	action :create
	mode 600
	owner "root"
	group "root"
end

directory "/home/vftp" do
	action :create
	owner "root"
	group "root"
end

directory "/home/vftp/openlmis" do
		mode 0755
		action :create
		owner "root"
	 	group "root"
end

execute "change mode for directory" do
	command "chown -R ftp:ftp /home/vftp"
end

directory "/etc/vsftpd/user_conf" do
	action :create
	owner "root"
	group "root"
end

%w{openlmis erp}.each do |file_name|
	cookbook_file "/etc/vsftpd/user_conf/#{file_name}" do
		action :create
		source "#{file_name}"
		mode 600
		owner "root"
		group "root"
		
	end
end
	
service "vsftpd" do
	action [:enable ,:start]
end


