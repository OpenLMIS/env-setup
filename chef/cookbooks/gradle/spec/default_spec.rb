require 'chefspec'

describe 'gradle::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.set["webapp"]={}
    node.set["webapp"]["home"]="/home/openlmis"
  end
  chef_run.converge 'gradle::default'
  
  it 'should download gradle zip' do
    chef_run.should create_remote_file "/home/openlmis/gradle-1.3-all.zip"
    chef_run.remote_file("/home/openlmis/gradle-1.3-all.zip").source.should == "http://services.gradle.org/distributions/gradle-1.3-all.zip"
    chef_run.remote_file("/home/openlmis/gradle-1.3-all.zip").should be_owned_by("openlmis", "openlmis")
    chef_run.remote_file("/home/openlmis/gradle-1.3-all.zip").mode.should == "0755"
  end

  it "should set gradle home" do
    chef_run.should execute_command "echo 'export PATH=/home/openlmis/gradle-1.3/bin:$PATH' >> /etc/bashrc"
  end
end
