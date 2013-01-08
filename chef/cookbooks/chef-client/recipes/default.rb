case node["platform"]
when "centos"
  include_recipe "chef-client::centos"
end
