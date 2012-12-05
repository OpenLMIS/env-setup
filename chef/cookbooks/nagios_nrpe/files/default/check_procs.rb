#!/usr/bin/env ruby

command_checkproc="ps aux |wc -l"
out_procs=`#{command_checkproc}`
exit_value=4

if $?.success?
	total_procs=out_procs.split("\n")[0]

	if total_procs.to_i > 700
		puts "CRITICAL Insufficient numproc | total_procs=#{total_procs}; "
		exit_value=2
	elsif total_procs.to_i > 500
		puts "WARNING High numproc utilization | total_procs=#{total_procs}; "
		exit_value=1 
	else		
		puts "OK numproc is fine | total_procs=#{total_procs}; "
		exit_value=0
	end
else
	puts "UNKNOWN Unable to execute #{command_checkproc}"
	exit_value=3
end
exit exit_value
