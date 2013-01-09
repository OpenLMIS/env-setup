require 'chefspec'

describe 'nagios_nrpe::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
  node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'nagios_nrpe::default'

  it 'should call nagios_nrpe::centos recipe' do
    chef_run.should include_recipe 'nagios_nrpe::centos'
  end
end

describe 'nagios_nrpe::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
  node.automatic_attrs['platform'] = 'ubuntu'
  end
  chef_run.converge 'nagios_nrpe::default'

  it 'should not call nagios_nrpe::centos recipe' do
    chef_run.should_not include_recipe 'nagios_nrpe::centos'
  end
end
