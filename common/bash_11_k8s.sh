function k8s::step {
  local OPTS=""
  if [ "$1" = "-n" ]; then
    shift
    OPTS+="-n"
  fi
  GREEN="$1"
  shift
  if [ -t 2 ] ; then
    echo -e ${OPTS} "\x1B[97m* \x1B[92m${GREEN}\x1B[39m $*" >&2
  else
    echo ${OPTS} "* ${GREEN} $*" >&2
  fi
}

function k8s::wait-for {
  local title="$1"
  local action="$2"
  local what="$3"
  shift 3
  k8s::step "Waiting for:" "${title}"
  while ! "${action}" "${what}" "$@"; do
    echo -n "." >&2
    sleep 1
  done
  echo "[done]" >&2
}

function k8s::pods-ready {
  local label="$1"
  local out
  if ! out="$(kubectl get pod "$@" -o jsonpath='{ .items[*].status.conditions[?(@.type == "Ready")].status }' 2>/dev/null)"; then
    return 1
  fi
  if ! grep -v False <<<"${out}" | grep -q True; then
    return 1
  fi
  return 0
}

function k8s::pod-ready {
  local label="$1"
  local out
  if ! out="$(kubectl get pod "$@" -o jsonpath='{ .status.conditions[?(@.type == "Ready")].status }' 2>/dev/null)"; then
    return 1
  fi
  if ! grep -v False <<<"${out}" | grep -q True; then
    return 1
  fi
  return 0
}

function wpods {
  k8s::wait-for "Pods ready: $*" k8s::pods-ready "$@"
}

function wpod {
  k8s::wait-for "Pod ready: $*" k8s::pod-ready "$@"
}

function kwpods {
  wpods -n kube-system "$@"
}

function kwpod {
  wpod -n kube-system "$@"
}

function kc {
  kubectl "$@"
}

function kp {
  kubectl get pods -o wide
}

function kpw {
  kubectl get pods -o wide -w
}

function kg {
  kubectl get "$@"
}

function ap {
  kubectl get pods --all-namespaces -o wide
}

function apw {
  kubectl get pods --all-namespaces -o wide -w
}

function kap {
  kubectl get nodes  
  kubectl get pods -n kube-system -o wide
}

function kapw {
  kubectl get nodes  
  kubectl get pods -n kube-system -o wide -w
}

function ww {
  watch --interval=0.5 kubectl get pods --all-namespaces -o wide
}

# function bdind {
#   rsync -avz --delete /Users/ivan4th/work/kubeadm-dind-cluster/ lab3:kubeadm-dind-cluster/ &&
#   ssh lab3 "cd kubeadm-dind-cluster && DOCKER_HOST=tcp://127.0.0.1:2375 build/build-local.sh" &&
#   echo "*** ok"
# }

function bdind {
  rsync -avz --delete /Users/ivan4th/work/kubeadm-dind-cluster/ lab:kubeadm-dind-cluster/ &&
  ssh lab "cd kubeadm-dind-cluster && build/build-local.sh" &&
  echo "*** ok"
}

function ldind {
  time DIND_IMAGE=mirantis/kubeadm-dind-cluster:local ~/work/kubeadm-dind-cluster/dind-cluster.sh "$@"
}

function ldindup {
  ldind up
}

function ldindc {
  ldind clean
}

function ldindupc {
  ldind clean
  ldind up
}
