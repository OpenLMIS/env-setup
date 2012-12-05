node["nagios"] ||= {}
node["nrpe"] ||= {}
node["nagios"]["plugins_dir"] = "/usr/lib64/nagios/plugins"
node['hw_nagios_server'] = "10.10.1.96"
