require 'chefspec'

describe 'chef-client::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
    node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'chef-client::default'

  it 'should call chef-client::centos recipe' do
    chef_run.should include_recipe 'chef-client::centos'
  end
end
