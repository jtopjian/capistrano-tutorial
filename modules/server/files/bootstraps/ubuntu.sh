#!/bin/bash

# Installing curl and wget
apt-get update
apt-get install -y curl wget

echo "Installing Rake, Ruby 1.9"
apt-get update
apt-get install -y git rake ruby1.9.3

echo "Setting ruby1.9 as the default"
update-alternatives --set ruby /usr/bin/ruby1.9.1
update-alternatives --set gem /usr/bin/gem1.9.1
