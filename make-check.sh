rm ~/.ssh/known_hosts -f
sleep 60
ssh -o StrictHostKeyChecking=no 192.168.100.2 ls
cd output/build/glibc/build
make test-wrapper="`pwd`/../scripts/cross-test-ssh.sh --timeoutfactor 6000 192.168.100.2" check > make_check_target.log 2>&1
ssh 192.168.100.2 -o ServerAliveCountMax=3 -o ServerAliveInterval=1 poweroff -f
tail make_check_target.log
