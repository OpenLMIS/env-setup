#!/usr/bin/env ruby

command_diskspace="df -h /"
out_space=`#{command_diskspace}`
exit_value=4

if $?.success?
	drive_space,total_space,used_space,free_space,perc_space,mpoint_disk=out_space.split("\n")[1].split(/\s+/)
	perc_space=perc_space.gsub('%','').to_i

	if perc_space > 90
		puts "CRITICAL Disk usage is more than 90% | perc_space=#{perc_space}; total_space=#{total_space}; used_space=#{used_space}; "
		exit_value=2
	elsif perc_space > 80
		puts "WARNING Disk usage is more than 80% | perc_space=#{perc_space}; total_space=#{total_space}; used_space=#{used_space}; "
		exit_value=1 
	else		
		puts "OK Disk usage is fine | perc_space=#{perc_space}; total_space=#{total_space}; used_space=#{used_space}; "
		exit_value=0
	end
else
	puts "UNKNOWN Unable to execute #{command_diskspace}"
	exit_value=3
end
exit exit_value
