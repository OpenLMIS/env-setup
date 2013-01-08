require 'chefspec'

describe 'git::default' do
  chef_run = ChefSpec::ChefRunner.new do |node| 
    node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'git::default'

  it 'should call git::centos recipe' do
    chef_run.should include_recipe 'git::centos'
  end
end
