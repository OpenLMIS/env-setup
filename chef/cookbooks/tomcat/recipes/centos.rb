#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 

remote_file "#{node["webapp"]["home"]}/apache-tomcat-7.0.33.tar.gz" do
  source "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.33/bin/apache-tomcat-7.0.33.tar.gz"
  owner "openlmis"
  group "openlmis"
  mode "0775"
  notifies :run, "execute[Installing Tomcat tarball]", :immediately
end

execute "Installing Tomcat tarball" do
  command "tar -xvf #{node["webapp"]["home"]}/apache-tomcat-7.0.33.tar.gz --directory=#{node["webapp"]["home"]}; chown -R openlmis:openlmis #{node["webapp"]["home"]}/apache-tomcat-7.0.33"
  action :nothing
end

cookbook_file "/etc/init.d/tomcat" do
  group "root"
  mode "0755"
  notifies :run, "execute[Add tomcat to chkconfig]", :immediately
end

template "#{node["webapp"]["home"]}/apache-tomcat-7.0.33/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner "openlmis"
  group "openlmis"
  mode "0755"
  action :create
end

execute "Add tomcat to chkconfig" do
  command "chkconfig --add tomcat; chkconfig tomcat on"
  action :nothing
  notifies :start, "service[tomcat]", :immediately
end

service "tomcat" do
  supports :start => true, :stop => true, :restart => true
  action :start
end
