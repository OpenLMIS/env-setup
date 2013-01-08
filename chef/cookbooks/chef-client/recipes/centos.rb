# Cookbook Name:: chef-client
# Recipe:: centos
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

cron "Run chef client every 30 minutes" do
  command "/usr/bin/chef-client"
  minute "30" 
end
