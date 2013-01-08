require 'chefspec'

describe 'git::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'git::centos' }
  it 'should install git' do
    chef_run.should install_package 'git'
  end
end
