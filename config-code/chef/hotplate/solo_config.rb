#!/usr/bin/env ruby

root = File.absolute_path(File.join File.dirname(__FILE__), '..')

file_cache_path root
cookbook_path root + '/cookbooks'