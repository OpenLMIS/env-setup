require 'chefspec'

describe 'nagios_nrpe::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'nagios_nrpe::centos' }
  
  ["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all"].each do |pkg|
    it "should install #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it "should place nrpe config file in /etc/nagios" do
    chef_run.should create_file "/etc/nagios/nrpe.cfg"
  end

  it "/etc/nagios/nrpe.cfg should be owned by root and have mode 0644" do
    chef_run.template("/etc/nagios/nrpe.cfg").should be_owned_by("root", "root")
    chef_run.template("/etc/nagios/nrpe.cfg").mode.should == "0644"
    chef_run.template("/etc/nagios/nrpe.cfg").source.should == "nrpe.cfg.erb"
  end

  it "should place system.cfg in /etc/nrpe.d" do
    chef_run.should create_file "/etc/nrpe.d/system.cfg"
  end

  it "/etc/nrpe.d/system.cfg should be owned by root and have mode 0644" do
    chef_run.template("/etc/nrpe.d/system.cfg").should be_owned_by("root", "root")
    chef_run.template("/etc/nrpe.d/system.cfg").mode.should == "0644"
    chef_run.template("/etc/nrpe.d/system.cfg").source.should == "system.cfg.erb"
    chef_run.template("/etc/nrpe.d/system.cfg").should notify ("service[nrpe]", :restart)
  end

  ["check_jenkins","check_apache","check_tomcat","check_postgresql","check_inode", "check_memory", "check_space", "check_procs"].each do |file|
    it "should place #{file} in /usr/lib64/nagios/plugins" do
      chef_run.should create_cookbook_file "/usr/lib64/nagios/plugins/#{file}"
      chef_run.cookbook_file("/usr/lib64/nagios/plugins/#{file}").should be_owned_by("root", "root")
      chef_run.cookbook_file("/usr/lib64/nagios/plugins/#{file}").source.should == file
      chef_run.cookbook_file("/usr/lib64/nagios/plugins/#{file}").mode.should == "755"
      chef_run.cookbook_file("/usr/lib64/nagios/plugins/#{file}").should notify ("service[nrpe]", :restart)
    end
  end

  it "should enable and start nrpe" do
    chef_run.should set_service_to_start_on_boot "nrpe"
    chef_run.should start_service "nrpe"
    chef_run.service("nrpe").supports.should == {:restart => true}
  end
end
