#!/bin/sh

# Install sudo and allow vagrant user to run it
env ASSUME_ALWAYS_YES=yes pkg install sudo
echo "%wheel ALL=(ALL) ALL" >> /usr/local/etc/sudoers
echo "vagrant ALL=NOPASSWD: ALL" >> /usr/local/etc/sudoers

# Allow vagrant to ssh using the insecure public key
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Remove the PermitRootLogin put in place to run this script
sed -i -e '/^PermitRootLogin/d' /etc/ssh/sshd_config

# Add in the open-vm-tools for shared folder support
env ASSUME_ALWAYS_YES=yes pkg install open-vm-tools-nox11
echo 'vmware_guestd_enable="YES"' >> /etc/rc.conf
echo 'vmware_guest_vmblock_enable="YES"' >> /etc/rc.conf
echo 'vmware_guest_vmhgfs_enable="YES"' >> /etc/rc.conf
echo 'vmware_guest_vmmemctl_enable="YES"' >> /etc/rc.conf
echo 'vmware_guest_vmxnet_enable="YES"' >> /etc/rc.conf

# Now do some additional customization
env ASSUME_ALWAYS_YES=yes pkg install git
