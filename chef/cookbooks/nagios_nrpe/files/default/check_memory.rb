#!/usr/bin/env ruby

command="free -m"
out=`#{command}`
exit_value=4

if $?.success?
	ram,total_ram,used_ram,free_ram,shared_mem,buffer_mem,cache_mem=out.split("\n")[1].split(/\s+/)
	net_used_ram=(used_ram.to_f-(buffer_mem.to_f+cache_mem.to_f))
  perc_ram=(net_used_ram.to_f/total_ram.to_f)*100

if perc_ram > 95
		puts "CRITICAL RAM usage is more than 95% | perc_ram=#{perc_ram}; used_ram=#{net_used_ram}; total_ram=#{total_ram}; "
		exit_value=2
	elsif perc_ram > 85
		puts "WARNING RAM usage is more than 85% | perc_ram=#{perc_ram}; used_ram=#{net_used_ram}; total_ram=#{total_ram}; "
		exit_value=1
	else
		puts "OK RAM usage is fine | perc_ram=#{perc_ram}; used_ram=#{net_used_ram}; total_ram=#{total_ram}; "
		exit_value=0
	end
else
	puts "UNKNOWN unable to execute #{command}"
	exit_value=3
end
exit exit_value
