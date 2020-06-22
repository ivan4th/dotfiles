settitle scapy
cd ~/work/travelping/scapy
workon scapy

function t {
  test/run_tests -P "load_contrib('pfcp')" -F -t test/contrib/pfcp.uts "$@" &&
    echo "*** OK ***"
}

function tpcaps {
  t -k pcaps
}

function tc {
  t -k current
}

function tt {
  ../scapytest.sh
}

function ttc {
  ../scapytest.sh -k current
}
