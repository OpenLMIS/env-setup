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


