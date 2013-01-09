require 'chefspec'

describe 'tomcat::default' do
  chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'centos'
  end
  chef_run.converge 'tomcat::default'

  it 'should include tomcat::centos recipe' do
    chef_run.should include_recipe 'tomcat::centos'
  end
end

describe 'tomcat::default' do
 chef_run = ChefSpec::ChefRunner.new do |node|
    node.automatic_attrs['platform'] = 'ubuntu'
  end
  chef_run.converge 'tomcat::default'

  it 'should not include tomcat::centos recipe' do
    chef_run.should_not include_recipe 'tomcat::centos'
  end
end
