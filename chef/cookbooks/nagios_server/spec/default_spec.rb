require 'chefspec'

describe 'nagios_server::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
  node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'nagios_server::default'

  it 'should call nagios_server::centos recipe' do
    chef_run.should include_recipe 'nagios_server::centos'
  end
end

describe 'nagios_server::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
  node.automatic_attrs['platform'] = 'ubuntu'
  end
  chef_run.converge 'nagios_server::default'

  it 'should not call nagios_server::centos recipe' do
    chef_run.should_not include_recipe 'nagios_server::centos'
  end
end
