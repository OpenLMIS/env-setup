require 'chefspec'

describe 'tomcat::disable_cache' do
  chef_run = ChefSpec::ChefRunner.new.converge 'tomcat::disable_cache'
  
  it 'should disable cache in tomcat' do
#    tomcat_home = "/home/openlmis/apache-tomcat-7.0.33"
    
    chef_run.execute("Disable Cache").should notify("service[tomcat]", :restart)
#    chef_run.should execute_command "sed -i 's/<Context>/<Context cachingAllowed='false'>/g' #{tomcat_home}/conf/context.xml"
  end
end
