sleep 60
cd output/build/glibc/build
make test-wrapper="`pwd`/../scripts/cross-test-ssh.sh --timeoutfactor 6000 172.16.170.233" check > make_check_target.log 2>&1
ssh 172.16.170.233 -o StrictHostKeyChecking=no -o ServerAliveCountMax=3 -o ServerAliveInterval=1 poweroff -f
tail make_check_target.log
