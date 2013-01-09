require 'chefspec'

describe 'httpd::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'httpd::default'
 
  it 'should include httpd::centos recipe' do
    chef_run.should include_recipe 'httpd::centos'
  end
end

describe 'httpd::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'ubuntu'
  end
  chef_run.converge 'httpd::default'
 
  it 'should include httpd::centos recipe' do
    chef_run.should_not include_recipe 'httpd::centos'
  end
end
