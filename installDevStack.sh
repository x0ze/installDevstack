#!/bin/bash

# Add User
sudo useradd -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack

# Add right for user
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

sudo -u stack -i <<EOF
  git clone https://opendev.org/openstack/devstack
  cd devstack
  touch local.conf
  echo "[[local|localrc]]" > local.conf
  echo "ADMIN_PASSWORD=secret" >> local.conf
  echo "DATABASE_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
  echo "RABBIT_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
  echo "SERVICE_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
EOF