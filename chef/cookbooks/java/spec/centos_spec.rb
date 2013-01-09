require 'chefspec'

describe 'java::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'java::centos' }

  ["java", "java-1.7.0-openjdk", "java-1.7.0-openjdk-devel"].each do |pkg|
    it "should install package #{pkg} " do
      chef_run.should install_package pkg
    end
  end
end
