require 'chefspec'

describe 'tomcat::centos' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.set["webapp"] = {}
    node.set["webapp"]["home"]="/home/openlmis"
  end
  node = chef_run.node
  chef_run.converge 'tomcat::centos'
  
it 'should get remote_file apache-tomcat-7.0.33.tar.gz and notify' do
    chef_run.remote_file("/home/openlmis/apache-tomcat-7.0.33.tar.gz").should be_owned_by("openlmis","openlmis")
  chef_run.remote_file("/home/openlmis/apache-tomcat-7.0.33.tar.gz").mode.should == "0775"
  chef_run.remote_file("/home/openlmis/apache-tomcat-7.0.33.tar.gz").source.should == "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.33/bin/apache-tomcat-7.0.33.tar.gz"
  chef_run.remote_file("/home/openlmis/apache-tomcat-7.0.33.tar.gz").should notify ("execute[Installing Tomcat tarball]",:run)
  end
  
 # it 'should execute installing Tomcat tarball' do
  #  chef_run.should execute_command "tar -xvf /tmp/apache-tomcat-7.0.33.tar.gz --directory=#{node["webapp"]["home"]}; chown -    R openlmis:openlmis #{node["webapp"]["home"]}/apache-tomcat-7.0.33"
 # end
 
  it 'should create file /etc/init.d/tomcat and notify' do
    chef_run.cookbook_file('/etc/init.d/tomcat').should be_owned_by("root","root")
    chef_run.cookbook_file('/etc/init.d/tomcat').mode.should == "0755"
    chef_run.cookbook_file('/etc/init.d/tomcat').source.should == "tomcat"
    chef_run.cookbook_file('/etc/init.d/tomcat').should notify("execute[Add tomcat to chkconfig]",:run)
  end
  
  it 'should execute Add tomcat to chkconfig' do
    chef_run.should execute_command "chkconfig --add tomcat; chkconfig tomcat on"
    chef_run.execute("Add tomcat to chkconfig").should notify("service[tomcat]",:start)
  end
  
  it 'should start service tomcat' do
   chef_run.should start_service "tomcat"
  end
end
