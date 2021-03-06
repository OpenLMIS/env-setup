require 'chefspec'

describe 'httpd::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'httpd::centos' }
  it 'should install httpd package' do
    chef_run.should install_package "httpd"
  end
  it 'should enable and start service httpd' do
   chef_run.should set_service_to_start_on_boot "httpd"
   chef_run.should start_service "httpd"
 end
end
