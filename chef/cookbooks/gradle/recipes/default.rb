#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 


remote_file "#{node["webapp"]["home"]}/gradle-1.6-all.zip" do
  source "http://services.gradle.org/distributions/gradle-1.6-all.zip"
  owner "openlmis"
  group "openlmis"
  mode "0755"
end

script "Gradle Installation" do
  interpreter "bash"
  user "openlmis"
  cwd node["webapp"]["home"]
  code <<-EOH
  cd #{node["webapp"]["home"]} 
  unzip -o #{node["webapp"]["home"]}/gradle-1.6-all.zip
  EOH
  not_if "gradle -v | grep 'Gradle 1.6'"
  notifies :run, "execute[Set gradle home]", :immediately
end

execute "Set gradle home" do
  command "echo 'export PATH=#{node["webapp"]["home"]}/gradle-1.6/bin:$PATH' >> /etc/bashrc"
  not_if "grep gradle-1.6 /etc/bashrc"
  action :nothing
end
