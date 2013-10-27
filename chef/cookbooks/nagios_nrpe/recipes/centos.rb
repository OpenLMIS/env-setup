#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 

["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all"].each do |pkg|
  package pkg
end

template "/etc/nagios/nrpe.cfg" do
  source "nrpe.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/nrpe.d/system.cfg" do
  source "system.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[nrpe]"; :immediately
end

["check_jenkins","check_apache","check_tomcat","check_postgresql","check_inode", "check_memory", "check_space", "check_procs"].each do |file|
  cookbook_file "/usr/lib64/nagios/plugins/#{file}" do
    source file
    owner "root"
    group "root"
    mode "755"
    notifies :restart, "service[nrpe]"; :immediately
  end
end

#execute "open port for nagios" do
#  command "iptables -I INPUT -p tcp -m tcp --dport 5666 -j ACCEPT"
#  action :run
#end

service "nrpe" do
  supports :restart => true
  action [:enable, :start]
  
  start_command "/usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d"
  stop_command "service nrpe stop"
  restart_command "service nrpe stop; /usr/sbin/nrpe -c /etc/nagios/nrpe.cfg -d"
end
