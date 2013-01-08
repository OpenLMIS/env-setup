require 'chefspec'

describe 'java::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'centos'
  end
   chef_run.converge 'java::default'

  it 'should include java::centos recipe' do
    chef_run.should include_recipe 'java::centos'
  end
end
