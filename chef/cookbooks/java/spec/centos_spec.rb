require 'chefspec'

describe 'java::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'java::centos' }
  it 'should install package java' do
    chef_run.should install_package "java"
  end
  it 'should install package java-1.7.0-openjdk' do
    chef_run.should install_package "java-1.7.0-openjdk"
  end
  it 'should install package java-1.7.0-openjdk-devel' do
    chef_run.should install_package "java-1.7.0-openjdk-devel"
  end
end
