#!/usr/bin/env ruby

command_diskinode="df -i /"
out_inode=`#{command_diskinode}`
exit_value=4

if $?.success?
	drive_inode,total_inode,used_inode,free_inode,perc_inode,mpoint_inode=out_inode.split("\n")[1].split(/\s+/)
	perc_inode=perc_inode.gsub('%','').to_i

	if perc_inode > 90
		puts "CRITICAL Disk usage is more than 90% | perc_inode=#{perc_inode}; total_inode=#{total_inode}; used_inode=#{used_inode}; "
		exit_value=2
	elsif perc_inode > 80
		puts "WARNING Disk usage is more than 80% | perc_inode=#{perc_inode}; total_inode=#{total_inode}; used_inode=#{used_inode}; "
		exit_value=1 
	else		
		puts "OK Disk usage is fine | perc_inode=#{perc_inode}; total_inode=#{total_inode}; used_inode=#{used_inode}; "
		exit_value=0
	end
else
	puts "UNKNOWN Unable to execute #{command_diskinode}"
	exit_value=3
end
exit exit_value
