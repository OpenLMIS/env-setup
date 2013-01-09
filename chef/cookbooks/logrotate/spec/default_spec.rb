require 'chefspec'

describe 'logrotate::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'logrotate::default'
 
  it 'should include logrotate::centos recipe' do
    chef_run.should include_recipe 'logrotate::centos'
  end
end

describe 'logrotate::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'ubuntu'
  end
  chef_run.converge 'logrotate::default'
 
  it 'should include logrotate::centos recipe' do
    chef_run.should_not include_recipe 'logrotate::centos'
  end
end
