#!/bin/sh

# to setup vm : wget https://raw.github.com/motech/motech-scm/master/bootstrap.sh && sh ./bootstrap.sh
#put configuration.pp in same path as bootstrap.sh

#install puppet if not exists
if ! type puppet > /dev/null 2>&1
then
  arch=`uname -m`

  epelFileName=`curl --location 'http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/'$arch'/' | grep epel-release | sed -e 's/^.*\(epel.*rpm\).*$/\1/g'`

  rpmUrl="http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/$arch/$epelFileName"

  cd /tmp && rpm -ivh "$rpmUrl"

  yum -y install puppet
fi

#set configuration file location
configurationFileLocation="./configuration.pp"
locationPathFromRoot=`echo $configurationFileLocation | cut -c 1 | grep / | wc -l`
if [ $locationPathFromRoot -eq 0 ]
then
  configurationFileLocation=`pwd`/$configurationFileLocation
fi

echo "MoTeCH: Bootstrap Machine:"

yum -y install git && \

cd /tmp/ && \

if [ ! -d /tmp/motech-scm/ ]
then
    git clone git://github.com/motech/motech-scm.git
else
    cd /tmp/motech-scm/ && git reset --hard && git pull --rebase && cd /tmp/
fi

cd /tmp/motech-scm/puppet && \

cp $configurationFileLocation manifests/nodes/configuration.pp

if [ "$DEBUG" = "true" ]; then
    puppet apply manifests/site.pp --debug --modulepath=modules/ && echo "Completed"
else
    puppet apply manifests/site.pp --modulepath=modules/ && echo "Completed"
fi
