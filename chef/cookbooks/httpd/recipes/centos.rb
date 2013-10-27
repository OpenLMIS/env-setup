#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 

package "httpd" do
  package_name "httpd"
  action :install
end

directory "/etc/httpd/conf.d/ssl" do
  owner "root"
  group "root"
  action :create
end

cookbook_file "etc/httpd/conf.d/openlmis.conf" do
  source "openlmis.conf"
  owner "root"
  group "root"
  mode "700"
end

cookbook_file "/etc/httpd/conf.d/ssl/apache_openlmis.key" do
  source "apache_openlmis.key"
  owner "root"
  group "root"
  mode "0600"	
end

cookbook_file "/etc/httpd/conf.d/ssl/apache_openlmis.crt" do
  source "apache_openlmis.crt"
  owner "root"
  group "root"
  mode "0600"	
end

yum_package "mod_ssl" do
  action :install
  flush_cache [:before]
end

service "httpd" do
  service_name "httpd"
  restart_command "/sbin/service httpd restart && sleep 1"
  reload_command "/sbin/service httpd reload && sleep 1"    

  action [:enable, :start]
end

