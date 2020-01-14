settitle lcm
export GOPATH="${HOME}/work/kubernetes"
export PATH="${PATH}:${HOME}/go-tools/bin"

# ldock

function ckctl {
  virtletctl ssh -n lcmdev ubuntu@k8s-0 -- -i ~/work/kubernetes/src/github.com/Mirantis/virtlet/examples/vmkey "KUBECONFIG=/etc/kubernetes/admin.conf sudo -E kubectl $*"
}

function ckpods {
  ckctl get pods --all-namespaces -o wide
}

function cknodes {
  ckctl get nodes -o wide
}

function cktaints {
  ckctl describe nodes|egrep 'Name:|Taints:'
}

function lcmdump {
  kubectl logs -n lcmdev lcm-controller-0 --tail=1000 -f | grep --line-buffered '\*\*\* DUMP'
}

function lcmstatus {
  kubectl get lcmcluster -n lcmdev \
          -o jsonpath='ready: {.status.readyNodes} requested: {.status.requestedNodes} helmControllerDeployed: {.status.helmControllerDeployed}@' \
          ansible-sample-cluster "$@" |
    tr '@' '\n'
}

function lcmstatw {
  while true; do
    lcmstatus -w
    sleep 1
  done
}

cd ~/work/kubernetes/src/github.com/Mirantis/lcm
