<%#encoding: UTF-8%>
bash -c 

# ADD EPEL & RBEL REPOS
# ======================
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm

sudo rpm -Uvh http://rbel.co/rbel6
# END REPOS
# ======================


if [ ! -f /usr/bin/chef-client ]; then

sudo yum -y install gcc gcc-c++ kernel-devel make wget libxslt-devel libxml2-devel git autoconf flex bison openssl-devel libcurl-devel readline-devel kernel-headers zlib-devel ruby ruby-devel ruby-libs ruby-irb ruby-rdoc ruby-ri unzip rubygems ntp
  
fi

#### CLOCK SYNC #####
sudo ntpdate pool.ntp.org
sudo chkconfig ntpd on
sudo service ntpd start

#### Installing chef ####
sudo gem update --system
sudo gem install ohai --no-rdoc --no-ri --verbose
sudo gem install chef --no-rdoc --no-ri --verbose <%= bootstrap_version_string %>

#### Create OpenLMIS User ####
sudo useradd openlmis -c "For eLMIS Application"

#### Remove tty from sudoers defaults ####
sudo bash -c "echo \"openlmis        ALL=(ALL)       NOPASSWD: ALL\" >> /etc/sudoers"
sudo sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers

#### Chef Setup ####
sudo mkdir -p /etc/chef


sudo bash -c $'echo \'recipe_url \"https://github.com/OpenLMIS/env-setup/blob/master/chef-solo/chef-solo.tar.gz?raw=truez\"\' > /etc/chef/solo.rb'
sudo bash -c $"echo \'json_attribs \"https://raw.github.com/OpenLMIS/env-setup/master/chef-solo/solo.json\"\' >> /etc/chef/solo.rb'

chef-solo -c /etc/chef/solo.rb
