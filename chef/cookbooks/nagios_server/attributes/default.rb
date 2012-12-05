node["nagios"] ||= {}
node[:chef] ||= {}
node["nagios"]["plugins_dir"] = "/usr/lib64/nagios/plugins"
node["nagios"]["admins"] = {}
node["nagios"]["guests"] = {}
