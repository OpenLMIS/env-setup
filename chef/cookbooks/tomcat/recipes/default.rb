case node["platform"]
when 'centos'
  include_recipe 'tomcat::centos'
end
