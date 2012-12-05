#!/usr/bin/env ruby
require 'rubygems'
require 'mixlib/json'

command_get_chef_statfiles="ls -t /var/chef/reports | head -1"
latest_run_file=`#{command_get_chef_statfiles}`.strip
exit_value=3

if $?.success?
	chef_data = Mixlib::JSON.parse(IO.read("/var/chef/reports/#{latest_run_file}"))
	status = chef_data["success"]
	
	if status
		elapsed_time = chef_data["elapsed_time"]
		total_resources = chef_data["all_resources"].count
		updated_resources = chef_data["updated_resources"].count
  	puts "OK chef run successful | elapsed_time=#{elapsed_time}; total_resources=#{total_resources}; updated_resources=#{updated_resources}; "
  	exit_value=0
	
    elsif !status
		elapsed_time = 0
		total_resources = 0
		updated_resources = 0
		puts "WARNING chef run failure | elapsed_time=#{elapsed_time}; total_resources=#{total_resources}; updated_resources=#{updated_resources}; "
		exit_value=1
	
    else
		puts "CRITICAL Unable to execute chef run #{command_get_chef_statfiles}"
  	exit_value=2
	end
end
exit exit_value
