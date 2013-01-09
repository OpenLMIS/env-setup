require 'chefspec'

describe 'openlmis_config::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'openlmis_config::default' }

  it 'should create .ssh directory openlmis home with mode 0700' do
    chef_run.should create_directory "/home/openlmis/.ssh"
    chef_run.directory("/home/openlmis/.ssh").should be_owned_by("openlmis", "openlmis")
    chef_run.directory("/home/openlmis/.ssh").mode.should == "0700"
  end

  it "should place authorized_keys in /home/openlmis/.ssh with mode 0600" do
    chef_run.should create_cookbook_file "/home/openlmis/.ssh/authorized_keys"
    chef_run.cookbook_file("/home/openlmis/.ssh/authorized_keys").should be_owned_by("openlmis", "openlmis")
    chef_run.cookbook_file("/home/openlmis/.ssh/authorized_keys").source.should == "authorized_keys"
    chef_run.cookbook_file("/home/openlmis/.ssh/authorized_keys").mode.should == "0600"
  end

  it "should place config in /home/openlmis/.ssh with mode 0644" do
    chef_run.should create_cookbook_file "/home/openlmis/.ssh/config"
    chef_run.cookbook_file("/home/openlmis/.ssh/config").should be_owned_by("openlmis", "openlmis")
    chef_run.cookbook_file("/home/openlmis/.ssh/config").source.should == "config"
    chef_run.cookbook_file("/home/openlmis/.ssh/config").mode.should == "0644"
  end

  it "should place openlmis.sh in /etc/profile.d/ with mode 0644" do
    chef_run.should create_file "/etc/profile.d/openlmis.sh"
    chef_run.template("/etc/profile.d/openlmis.sh").source.should == "openlmis.sh.erb"
    chef_run.template("/etc/profile.d/openlmis.sh").should be_owned_by("openlmis", "openlmis")
    chef_run.template("/etc/profile.d/openlmis.sh").mode.should == "0644"
  end
end
