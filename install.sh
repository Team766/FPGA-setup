#! /bin/bash
# root check
if [ $EUID -ne 0 ]; then
    echo "Please run this with root"
    exit 1
fi
# check for onboot in CWD
if [ ! -f onboot.sh ]; then
    echo "run in the FPGA repo dir"
    exit 2
fi
# go for it
cp onboot.sh /
# modify perms on /onboot.sh
chmod 744 /onboot.sh
# copy and configure system file
cp FPGAonBoot.service /etc/systemd/system
chmod 755 /etc/systemd/system/FPGAonBoot.service
systemctl daemon-reload
# set up ethernet bridge and start everything
nmcli conn add type bridge con-name br0 ifname br0
systemctl enable --now FPGAonBoot.service
