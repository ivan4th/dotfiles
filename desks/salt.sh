settitle salt
cd ~/work/lea/salt-state

export SALT_CONFIG_DIR=~/work/lea/salt-state/testing

function sm {
  rm -rf $SALT_CONFIG_DIR/var/cache/salt
  salt-master --log-level=debug --log-file=/tmp/salt.log
}
