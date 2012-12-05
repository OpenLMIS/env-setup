case node["platform"]
  when "redhat","centos","scientific","fedora","suse", "amazon"
    set["apache"]["dir"] = "/etc/httpd"
    set["apache"]["log_dir"] = "/var/log/httpd"
    set["apache"]["user"] = "apache"
    set["apache"]["group"] = "apache"
    set["apache"]["binary"] = "/usr/sbin/httpd"
    set["apache"]["icondir"] = "/var/www/icons/"
    set["apache"]["cache_dir"] = "/var/cache/httpd"
    if node['platform_version'].to_f >= 6 then
      set["apache"]["pid_file"] = "/var/run/httpd/httpd.pid"
    else
      set["apache"]["pid_file"] = "/var/run/httpd.pid"
    end
    set["apache"]["lib_dir"] = node["kernel"]["machine"] =~ /^i[36]86$/ ? "/usr/lib/httpd" : "/usr/lib64/httpd"
end 


default["apache"]["listen_ports"] = [ "80","443" ]
default["apache"]["contact"] = "ops@example.com"
default["apache"]["timeout"] = 300
default["apache"]["keepalive"] = "On"
default["apache"]["keepaliverequests"] = 100
default["apache"]["keepalivetimeout"] = 5

