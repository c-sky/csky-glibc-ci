rm ~/.ssh/known_hosts -f
sleep 60
ssh -o StrictHostKeyChecking=no 172.16.170.121 ls
make test-wrapper="`pwd`/../scripts/cross-test-ssh.sh --timeoutfactor 6000 172.16.170.121" check > make_check.log 2>&1
ssh 172.16.170.121 poweroff
