# Cookbook Name::java
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute

case node["platform"]
when "centos"
  include_recipe "java::centos"
end
