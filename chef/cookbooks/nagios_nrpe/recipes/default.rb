case node['platform']
when "centos"
  nrpe_packages = ["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all"]
  nrpe_service_name = "nrpe"
	nrpe_user = "nrpe"
when "ubuntu"
  nrpe_packages = ["nagios-nrpe-server", "nagios-plugins", "libcurl3-openssl-dev"]
  nrpe_service_name = "nagios-nrpe-server"
	nrpe_user = "nagios"
end

nrpe_packages.each do |pkg|
  package pkg 
end

gem_package "mixlib-json"

directory "/etc/nrpe.d" do
  owner "root"
  group "root"
  mode "644"
end

directory "/var/run/nrpe" do
  owner nrpe_user
	group nrpe_user
	mode "755"
end

template "/etc/nagios/nrpe.cfg" do
  node["nagios"]["ssh_port"] ||= '22'
  
  source "nrpe.cfg.erb"
  owner "root"
  group "root"
  mode "644"
  variables(:nrpe_user => nrpe_user)
  notifies :restart, "service[#{nrpe_service_name}]"
end

node["nrpe"].each do |name, command|
  template "/etc/nrpe.d/#{name}.cfg" do
    source "nrpe_command.cfg.erb"
    owner "root"
    group "root"
    mode "644"

    variables(:name => name, :command => command)
    notifies :restart, "service[#{nrpe_service_name}]"
  end
end unless node["nrpe"].nil?

cookbook_file "/etc/nrpe.d/monkeys.cfg" do
  source "monkeys.cfg"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, "service[#{nrpe_service_name}]"
end

%w{system.cfg handlers.cfg}.each do |config| 
	template "/etc/nrpe.d/#{config}" do
  	  source "#{config}.erb"
  	  owner "root"
  	  group "root"
  	  mode "644"
  	  notifies :restart, "service[#{nrpe_service_name}]"
	end
end

cron "copy_over_ubc" do
    command "cp -f /proc/user_beancounters /etc/nagios/user_beancounters; chmod 444 /etc/nagios/user_beancounters"
    minute "*/15"
    user "root"
end

["check_convergence","check_space.rb","check_procs.rb","check_inode.rb","check_memory.rb","chef_stat.rb","check_UBC.rb"].each do |check|
  cookbook_file "/usr/lib64/nagios/plugins/#{check}" do
    source check
    owner "root"
    group "root"
    mode "755"
    notifies :restart, "service[#{nrpe_service_name}]"
	end
end

service nrpe_service_name do
  action [:enable, :start]
  supports :status => true, :reload => true, :restart => true
end

#### Event Handlers #######

directory "/usr/lib64/nagios/plugins/eventhandlers" do
	owner "root"
	group "root"
	mode "0755"
end

%w{restart-chef restart-go}.each do |handler|
cookbook_file "/usr/lib64/nagios/plugins/eventhandlers/#{handler}" do
        source handler
        owner "root"
        group "root"
        mode "0755"
        end
end

cookbook_file "/opt/sudo_nrpe.rb" do
  source "sudo_nrpe.rb"
  owner "root"
  group "root"
  mode "0755"
end

execute "Add nrpe to sudoers" do
  command "/usr/bin/ruby /opt/sudo_nrpe.rb"
  user "root"
  action :run
  not_if do
    File.exists?("/opt/sudoers_backup")
  end
end
