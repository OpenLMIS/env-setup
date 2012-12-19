#
# Cookbook Name:: jenkins-build-slave
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

cookbook_file "/etc/yum.repos.d/jenkins.repo" do
  source "jenkins.repo"
  owner "root"
  group "root"
  mode  "0644"
end

package "jenkins"

service "jenkins" do
  action :enable
end
