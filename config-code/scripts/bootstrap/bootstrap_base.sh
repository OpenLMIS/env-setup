#!/bin/sh

# data
omnibus='/tmp/bootstrap/chef/omnibus.sh'
omnibus_url='http://opscode.com/chef/install.sh'

# creating required dir-struct
mkdir -p /tmp/bootstrap/chef

# installing chef omnibus
curl -L -o $omnibus $omnibus_url
sh $omnibus
