configurationFileLocation=`pwd`/configuration.pp

cd /tmp && \
wget -O bootstrap.sh https://raw.github.com/motech/motech-scm/incremental-deployment/bootstrap.sh && \
sh ./bootstrap.sh $configurationFileLocation