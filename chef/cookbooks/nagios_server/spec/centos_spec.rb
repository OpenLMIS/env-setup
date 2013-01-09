require 'chefspec'

describe 'nagios_server::centos' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.set["nagios"] ||= {}
    node.set["nagios"]["plugins_dir"] = "/usr/lib64/nagios/plugins"
    node.set["nagios"]["admins"] = {"admin" => "admin" }
    node.set["nagios"]["guests"] = {"guest" => "guest"}
    Chef::Recipe::CI_servers = "ci.server.com"
    Chef::Recipe::QA_servers = "qa.server.com"
    Chef::Recipe::UAT_servers = "uat.server.com"
  end
  chef_run.converge 'nagios_server::centos'
 
  it 'should include recipe for httpd' do
    chef_run.should include_recipe 'httpd'
  end

  %w{nagios php nagios-plugins-all pnp4nagios}.each do |pkg|
    it "should install #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it "should enable and start httpd" do
    chef_run.should start_service "httpd"
    chef_run.should set_service_to_start_on_boot "httpd"
    chef_run.service("httpd").supports.should == {:restart=>true}
  end

  it "should create /etc/nagios/passwd" do
    chef_run.should create_file "/etc/nagios/passwd"
    chef_run.file("/etc/nagios/passwd").should be_owned_by("nagios", "nagios")
  end

  it "should update password file for admins and restart httpd" do
    chef_run.execute("update the passwords file for admins").should notify("service[httpd]", :restart)
  end

  it "should update password file for guests and restart httpd" do
    chef_run.execute("update the passwords file for guests").should notify("service[httpd]", :restart) 
  end

  it "should change permissions for client.pem" do
    chef_run.should execute_command "chmod 644 /etc/chef/client.pem"
  end

  it "should create /var/www/html/index.html with mode 0755" do
    chef_run.should create_cookbook_file("/var/www/html/index.html")
    chef_run.cookbook_file("/var/www/html/index.html").source.should == "index.html"
    chef_run.cookbook_file("/var/www/html/index.html").mode.should == "0755"
  end
  
  ["templates","hosts", "services", "commands", "localhost"].each do |obj|  
    it "should add config files" do
      chef_run.should create_file "/etc/nagios/objects/#{obj}.cfg"
      chef_run.template("/etc/nagios/objects/#{obj}.cfg").should be_owned_by("root", "root")
      chef_run.template("/etc/nagios/objects/#{obj}.cfg").mode.should == "644"
      chef_run.template("/etc/nagios/objects/#{obj}.cfg").should notify("service[nagios]", :restart)  
    end
  end

  it "should run nagios config check" do
    chef_run.should execute_command "nagios -v /etc/nagios/nagios.cfg"
  end

  it "should enable and start nrpe" do
    chef_run.should start_service "nrpe"
    chef_run.should set_service_to_start_on_boot "nrpe"
    chef_run.service("nrpe").supports.should == {:restart => true}
  end

  it "should enable and start nagios" do
    chef_run.should start_service "nagios"
    chef_run.should set_service_to_start_on_boot "nagios"
    chef_run.service("nagios").supports.should == {:restart => true}
  end
end
