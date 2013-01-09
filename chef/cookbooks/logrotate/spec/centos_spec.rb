require 'chefspec'

describe 'logrotate::centos' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.set["tomcat_package"]="apache-tomcat-7.0.33"
    node.set["webapp_home"]="/home/openlmis" 
  end
  
  chef_run.converge 'logrotate::centos'

  it "should install logrotate" do
    chef_run.should install_package "logrotate"
  end
 
  it "should place openlmis config in /etc/logrotate.d/" do
    chef_run.should create_file "/etc/logrotate.d/openlmis"
    chef_run.template("/etc/logrotate.d/openlmis").source.should == "openlmis.erb"
    chef_run.template("/etc/logrotate.d/openlmis").should be_owned_by("root", "root")
    chef_run.template("/etc/logrotate.d/openlmis").mode.should == "0644"
  end
end
