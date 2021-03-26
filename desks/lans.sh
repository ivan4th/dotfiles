settitle lans
cd ~/work/lea/code/lea-ansible
. venv/bin/activate
export ANSIBLE_STRATEGY=mitogen_linear
export ANSIBLE_STRATEGY_PLUGINS=$PWD/venv/lib/python3.9/site-packages/ansible_mitogen/plugins/strategy
