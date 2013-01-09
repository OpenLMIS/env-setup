require 'chefspec'

describe 'iptables::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'iptables::default' }
  it 'should stop iptables' do
    chef_run.should stop_service "iptables"
  end
end
