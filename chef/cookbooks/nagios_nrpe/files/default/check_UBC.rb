#!/usr/bin/env ruby

exit_value=3
ub_counters=File.read('/etc/nagios/user_beancounters').split("\n")
	ub_counters.shift
	ub_counters.shift
	ub_counters[0]=ub_counters[0].gsub(/^\s+\d+:\s*/,'')

	data=ub_counters.collect{|el| el.split("\s")}
	fail_count_list=ub_counters.select{|el| el !~/0$/}.collect{|el| el.strip.split(/\s+/).first}

    if fail_count_list.count >= 1
        failed_UBC=fail_count_list.join(" ")
        puts "CRITICAL System #{failed_UBC} failed | kmemsize=#{data[0][2]}; privvmpages=#{data[2][2]}; numproc=#{data[5][2]}; physpages=#{data[6][2]}; vmguarpages=#{data[7][2]}; oomguarpages=#{data[8][2]}; numtcpsock=#{data[9][2]}; numpty=#{data[11][2]}; tcpsndbuf=#{data[13][2]}; tcprcvbuf=#{data[14][2]}; othersockbuf=#{data[15][2]}; numothersock=#{data[17][2]}; dcachesize=#{data[18][2]}; numfile=#{data[19][2]}; "
        exit_value=2

	elsif fail_count_list.empty?
		puts "OK System UBC are fine | kmemsize=#{data[0][2]}; privvmpages=#{data[2][2]}; numproc=#{data[5][2]}; physpages=#{data[6][2]}; vmguarpages=#{data[7][2]}; oomguarpages=#{data[8][2]}; numtcpsock=#{data[9][2]}; numpty=#{data[11][2]}; tcpsndbuf=#{data[13][2]}; tcprcvbuf=#{data[14][2]}; othersockbuf=#{data[15][2]}; numothersock=#{data[17][2]}; dcachesize=#{data[18][2]}; numfile=#{data[19][2]}; "
		exit_value=0

	else
		puts "WARNING System UBC not retrieved | "
		exit_value=1
	end
exit exit_value
