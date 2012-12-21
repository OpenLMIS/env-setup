#
# Cookbook Name:: postgres
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

execute "Install PostgreSQL repository" do
  command "rpm -Uvh http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm"
  not_if "test -f /etc/yum.repos.d/pgdg-91-redhat.repo"
end

package "postgresql91" do
  action :install
end

["postgresql.conf", "pg_hba.conf"].each do |config_file|
  template "/var/lib/pgsql/9.1/data/#{config_file}" do
    source "#{config_file}.erb"
    owner "postgres"
    group "postgres"
    mode "0600"
    notifies :restart, "service[postgresql-9.1]", :immediately
  end
end

package "postgresql91-server" do
  action :install
  notifies :run, "execute[postgres_initialize_db]", :immediately
end

execute "postgres_initialize_db" do
  command "service postgresql-9.1 initdb"
  action :nothing
end

#execute "open port for postgres" do
#  command "iptables -I INPUT -p tcp -m tcp --dport 5432 -j ACCEPT"
#  action :run
#end

service "postgresql-9.1" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
