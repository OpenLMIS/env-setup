#/
 # This program is part of the OpenLMIS logistics management information system platform software.
 # Copyright © 2013 VillageReach
 #
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 #  
 # This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.
 # You should have received a copy of the GNU Affero General Public License along with this program.  If not, see http://www.gnu.org/licenses.  For additional information contact info@OpenLMIS.org. 
 #/ 
execute "Install PostgreSQL repository" do
  command "rpm -Uvh http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm"
  not_if "test -f /etc/yum.repos.d/pgdg-91-redhat.repo"
end

package "postgresql91" do
  action :install
end

link "/etc/init.d/postgresql" do
  to "/etc/init.d/postgresql-9.1"
  not_if "test -f /etc/init.d/postgresql"
end

template "/var/lib/pgsql/9.1/data/postgresql.conf" do
  source "postgresql.conf"
  owner "postgres"
  group "postgres"
  mode "0600"
  notifies :restart, "service[postgresql]", :immediately
end

template "/var/lib/pgsql/9.1/data/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode "600"
  notifies :restart, "service[postgresql]", :immediately
end

package "postgresql91-server" do
  action :install
  notifies :run, "execute[postgres_initialize_db]", :immediately
end

execute "postgres_initialize_db" do
  command "service postgresql initdb"
  action :nothing
end

#execute "open port for postgres" do
#  command "iptables -I INPUT -p tcp -m tcp --dport 5432 -j ACCEPT"
#  action :run
#end

service "postgresql" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

yum_package "postgresql91-contrib" do
  action :install
  flush_cache [:before]
end
