require 'chefspec'

describe 'chef-client::centos' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-client::centos' }
  it 'should add cron job to run chef client every 30 minutes' do
    pending 'No assertion for cron added to chefspec yet!'
  end
end
