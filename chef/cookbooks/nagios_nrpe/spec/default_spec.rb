require 'chefspec'

describe 'nagios_nrpe::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'nagios_nrpe::default' }
  it 'should install nrpe_packages' do
	chef_run.should install_package "nrpe"
  end
end
