#! /bin/bash
set -e
# redirect self to log file as well as console
exec > >(tee -i /var/log/user-data.log)
exec 2>&1

# Bootstrapping Start
rm -rf /tmp/bootstrap-complete

# Set Environment Variables
hostnamectl set-hostname ${hostname}

# Bootstrapping Coomplete
touch /tmp/bootstrap-complete
