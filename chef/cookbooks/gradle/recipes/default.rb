#
# Cookbook Name:: gradle
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

script "Gradle Installation" do
  interpreter "bash"
  user "root"
  cwd "/usr"
  code <<-EOH
  cd /usr
  wget http://services.gradle.org/distributions/gradle-1.3-all.zip
  unzip -o /usr/gradle-1.3-all.zip
  EOH
  not_if "gradle -v | grep Gradle"
  notifies :run, "execute[Set gradle home]", :immediately
end

execute "Set gradle home" do
  command 'echo "export PATH=/usr/gradle-1.3/bin:$PATH" >> ~/.bashrc'
  action :nothing
end
