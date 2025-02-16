#! /bin/bash
xmutil unloadapp
xmutil loadapp kr260-bist
# set up bridge, br0 shoudl exist
for i in {1..5}; do
    nmcli con del 'Wired connection ${i}' || true 1>&2 >> /dev/null
done
for i in {0..4}; do
    nmcli con add type ethernet slave-type bridge con-name bridge-br0 ifname eth$i master br0
done
