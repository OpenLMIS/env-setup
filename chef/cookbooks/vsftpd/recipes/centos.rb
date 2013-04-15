yum_package "vsftpd" do
	action :install
end
yum_package "db4-utils db4" do
	action :install
end

cookbook_file "/etc/vsftpd/vsftpd.conf" do
	source "vsftpd.conf"
	action :create
	mode 0755
	owner "root"
	group "root"
end

cookbook_file "/etc/vsftpd/vusers.txt" do
	source "virtual_users.txt"
	action :create
	mode 0755
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
	mode 0755
	owner "root"
	group "root"
end

directory "/home/vftp" do
	action :create
	owner "root"
	owner "root"
end

%w{'openlmis' 'erp'}.each do |dir|
	directory "/home/vftp/#{dir}" do
		mode 0755
		action :create
		owner "root"
		create "root"
	end
end

execute "change mode for directory" do
	command "chown -R ftp:ftp /home/vftp"
end

service "vsftpd" do
	action [:enable ,:start]
end

