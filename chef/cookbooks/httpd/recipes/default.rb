case node["platform"]
when "centos"
	include_recipe "httpd::centos"
end
