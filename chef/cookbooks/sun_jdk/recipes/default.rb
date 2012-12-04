#
# Cookbook Name:: sun_jdk
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Remove OpenJDK" do
  command "rpm -e java-1.6.0-openjdk-demo-1.6.0.0-1.50.1.11.5.el6_3.x86_64 java-1.6.0-openjdk-1.6.0.0-1.50.1.11.5.el6_3.x86_64 java-1.6.0-openjdk-javadoc-1.6.0.0-1.50.1.11.5.el6_3.x86_64 java-1.6.0-openjdk-src-1.6.0.0-1.50.1.11.5.el6_3.x86_64 java-1.6.0-openjdk-devel-1.6.0.0-1.50.1.11.5.el6_3.x86_64"
  only_if "rpm -qa | grep openjdk"
  action :run
end

cookbook_file "/tmp/jdk-7u9-linux-x64.rpm" do
  source "jdk-7u9-linux-x64.rpm"
  mode "0775"
  notifies :run, "execute[Install Java]", :immediately
end

execute "Install Java" do
  command "mkdir -p /usr/java; rpm -ivh /tmp/jdk-7u9-linux-x64.rpm"
  action :nothing
  notifies :run, "execute[set_java_home]", :immediately
end

execute "set_java_home" do
  command 'echo "export PATH=$PATH:/usr/java/jdk1.7.0_09/bin" >> ~/.bashrc; echo "export JAVA_HOME=/usr/java/jdk1.7.0_09/bin" >> ~/.bashrc'
  action :nothing
end
