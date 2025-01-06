#!/bin/bash

# Add User
useradd -s /bin/bash -d /opt/stack -m stack
chmod +x /opt/stack

# Add right for user
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

sudo -u stack -i <<EOF
  git clone https://opendev.org/openstack/devstack
  cd devstack
  touch local.conf
  echo "[[local|localrc]]" > local.conf
  echo "ADMIN_PASSWORD=secret" >> local.conf
  echo -e "DATABASE_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
  echo -e "RABBIT_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
  echo -e "SERVICE_PASSWORD=\$ADMIN_PASSWORD" >> local.conf
  ./stack.sh
EOF
