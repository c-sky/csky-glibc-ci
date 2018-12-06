rm ~/.ssh/known_hosts -f
sleep 60
ssh -o StrictHostKeyChecking=no 172.16.170.233 ls
cd output/build/glibc/build
make test-wrapper="`pwd`/../scripts/cross-test-ssh.sh --timeoutfactor 6000 172.16.170.233" check > make_check_target.log 2>&1
ssh 172.16.170.233 poweroff
tail make_check_target.log
