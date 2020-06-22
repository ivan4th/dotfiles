settitle vpp

cd ~/work/travelping/vpp

function build_image_name {
  local build_hash="$(git ls-tree HEAD -- Makefile build/external extras/docker/Dockerfile.build | md5sum | awk '{print $1}')"
  echo "quay.io/travelping/upf-build:${build_hash}"
}

function buildenv {
  docker run -it --rm --name vpp-build --shm-size 1024m \
         -v ~/work/travelping/vpp:/src/vpp:delegated \
         -v ~/rmme/vpp-out:/vpp-out \
         -e LC_ALL=C.UTF-8 -e LANG=C.UTF-8 \
         "$(build_image_name)" \
         "$@"
}

function tupf {
  rm -rf ~/rmme/vpp-out
  buildenv /bin/bash -c "if ! make -C /src/vpp test-debug TEST=test_upf V=2; then mv /tmp/vpp* /vpp-out/; exit 1; fi"
}

function rtupf {
  rm -rf ~/rmme/vpp-out
  buildenv /bin/bash -c "if ! make -C /src/vpp retest-debug TEST=test_upf V=2; then mv /tmp/vpp* /vpp-out/; exit 1; fi"
}

function rb {
  cd ~/work/travelping/vpp
  SRC_IMAGE="${SRC_IMAGE:-upf}"

  if ! docker run -it --rm --name vpp-build -v ~/work/travelping/vpp:/src/vpp:delegated "$(build_image_name)" make -C /src/vpp build; then
    echo >&2 "*** FAIL ***"
    return 1
  fi

  mkdir -p usr/share/vpp/api/plugins usr/lib/x86_64-linux-gnu/vpp_plugins
  cp build-root/install-vpp_debug-native/vpp/share/vpp/api/plugins/upf.api.json \
     usr/share/vpp/api/plugins
  cp build-root/install-vpp_debug-native/vpp/lib/vpp_plugins/upf_plugin.so \
     usr/lib/x86_64-linux-gnu/vpp_plugins
  # cp build-root/install-vpp_debug-native/vpp/share/vpp/api/plugins/upf.api.json \
  #    ../upf-controller/binapi/
  cp build-root/install-vpp_debug-native/vpp/lib/libvnet.so.20.09 \
     usr/lib/x86_64-linux-gnu/

  docker rm -fv vpp_tmp || true
  tar -c usr |
    docker run -i --name vpp_tmp --entrypoint /bin/bash "${SRC_IMAGE}" -c \
           'tar -C / -xv && apt-get update && apt-get install -y socat'
  docker commit --change 'ENTRYPOINT ["/usr/bin/vpp"]' vpp_tmp upf
  docker rm -fv vpp_tmp || true

  # cd ../upf-controller
  # rm -rf upf/
  # make generate

  # docker save docker.io/ergw/vpp:upf-fix |
  #   docker exec -i kind-control-plane ctr -n k8s.io images import -
}

function rb_rel {
  cd ~/work/travelping/vpp
  SRC_IMAGE="${SRC_IMAGE:-upf}"

  # FIXME
  if ! docker run -it --rm --name vpp-build -v ~/work/travelping/vpp:/src/vpp:cached "$(build_image_name)" make build-release; then
    echo >&2 "*** FAIL ***"
    return 1
  fi

  mkdir -p usr/share/vpp/api/plugins usr/lib/x86_64-linux-gnu/vpp_plugins
  cp build-root/install-vpp-native/vpp/share/vpp/api/plugins/upf.api.json \
     usr/share/vpp/api/plugins
  cp build-root/install-vpp-native/vpp/lib/vpp_plugins/upf_plugin.so \
     usr/lib/x86_64-linux-gnu/vpp_plugins
  cp build-root/install-vpp-native/vpp/lib/libvnet.so.20.05 \
     usr/lib/x86_64-linux-gnu/
  # cp build-root/install-vpp-native/vpp/share/vpp/api/plugins/upf.api.json \
  #   ../upf-controller/binapi/

  docker rm -fv vpp_tmp || true
  tar -c usr |
    docker run -i --name vpp_tmp --entrypoint /bin/bash "${SRC_IMAGE}" -c \
           'tar -C / -xv && apt-get update && apt-get install -y socat'
  docker commit --change 'ENTRYPOINT ["/usr/bin/vpp"]' vpp_tmp upf
  docker rm -fv vpp_tmp || true

  # cd ../upf-controller
  # rm -rf upf/
  # make generate

  # docker save docker.io/ergw/vpp:upf-fix |
  #   docker exec -i kind-control-plane ctr -n k8s.io images import -
}

function tst {
  if python -c 'import scapy.contrib.pfcp' &&
      test/run_tests -P "load_contrib('pfcp')" -F -t test/contrib/pfcp.uts "$@"; then
    return 0
  else
    return 1
  fi
}

function test_loop {
  f=
  while true; do
    if eval "${@}"; then
      echo "*** OK ***"
      if [[ ${f} ]]; then
        say "tests fixed"
      fi
      f=
    else
      echo "*** FAIL ***"
      if [[ ! ${f} ]]; then
        say "tests failed"
      fi
      f=1
      sleep 10
    fi
    sleep 5
  done
}

function tupf_loop {
  test_loop tupf
}

function rtupf_loop {
  test_loop rtupf
}
