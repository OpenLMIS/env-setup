#
# Cookbook Name:: sun_jdk
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

["java", "java-1.7.0-openjdk", "java-1.7.0-openjdk-devel"].each do |pkg|
  package pkg
end
