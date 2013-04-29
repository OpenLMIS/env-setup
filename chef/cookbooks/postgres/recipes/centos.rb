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

directory "/var/lib/pgsql/9.1/archive" do
  action :create
  owner "postgres"
  group "postgres"
  mode "644"
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
  notifies :run,"execute[create data backup]", :immediately
  action :nothing
end

#bash "create data backup" do
#  user "root"
#  cwd "#{node["postgreSQL"]["home"]}"
#  code<<-EOH
#        export PGDATA=#{node["postgreSQL"]["home"]}/data
#        psql -c \"SELECT pg_start_backup('initial backup for SR')" template
#        tar cvf pg_base_backup.tar $PGDATA
#        psql -c \"SELECT pg_stop_backup()\" template        
 # EOH
#end

execute "create data backup" do
  command "psql -c \"SELECT pg_start_backup('initial backup for SR')\""
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
