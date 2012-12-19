#
# Cookbook Name::java
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#

["java", "java-1.7.0-openjdk", "java-1.7.0-openjdk-devel"].each do |pkg|
  package pkg
end
