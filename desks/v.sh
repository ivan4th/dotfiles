settitle virtlet
export KPATH=$HOME/work/kubernetes
export GOPATH=$KPATH
export PATH=$PATH:$HOME/go-tools/bin
export KUBERNETES_SRC_DIR=$KPATH/src/k8s.io/kubernetes

ldock

cd ~/work/kubernetes/src/github.com/Mirantis/virtlet

function vpod {
    vpod=$(kubectl get pod -n kube-system -l runtime=virtlet -o jsonpath='{.items[0].metadata.name}')
    echo "${vpod}"
}

function vlog {
    kubectl logs -n kube-system "$(vpod)" -c "${1:-virtlet}"
}

function vsh {
    kubectl exec -it -n kube-system "$(vpod)" -c "${1:-virtlet}" /bin/bash
}

function vstart {
    build/cmd.sh build &&
        build/cmd.sh copy-dind &&
        FORCE_UPDATE_IMAGE=1 build/cmd.sh start-dind &&
        ap &&
        kwpods -l runtime=virtlet
    vpod
}

function vrun {
    ~/dind-cluster-v1.10.sh up && vstart
}

function vdel {
    kubectl delete daemonset -R --now virtlet
}

function prs {
    local tag="${1}"
    git fetch && git log --merges --pretty=format:"%s @@ %b" "${tag}"..origin/master |
            sed 's^.*#\([0-9]*\).* @@ \(.*\)^https://github.com/Mirantis/virtlet/pull/\1 \2^'; echo
}

function prs1 {
    local tag="${1}"
    git fetch && git log --merges --pretty=format:"%s @@ %b" "${tag}"..origin/master |
            sed 's^.*#\([0-9]*\).* @@ \(.*\)^\2 (#\1)^'; echo
}

function le2e {
  local focus="${1:-}"
  shift
  local -a opts=(-include-unsafe-tests=true
                 -ginkgo.v
                 -cluster-url "http://127.0.0.1:8899"
                 "$@")
  if [[ ${focus} ]]; then
    opts+=(-ginkgo.focus="${focus}")
  else
    opts+=(-ginkgo.skip="\[Heavy\]|\[MultiCNI\]")
  fi
  go test -i -c -o "_output/virtlet-e2e-tests" ./tests/e2e &&
    _output/virtlet-e2e-tests "${opts[@]}"
}
