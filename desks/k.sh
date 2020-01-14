settitle kube
export KPATH=$HOME/work/kubernetes
export GOPATH=$KPATH
export PATH=$PATH:$HOME/go-tools/bin
export KUBERNETES_SRC_DIR=$KPATH/src/k8s.io/kubernetes
cd $KUBERNETES_SRC_DIR
export KUBERNETES_PROVIDER=local
alias kc="$KUBERNETES_SRC_DIR/cluster/kubectl.sh"

export KUBE_RSYNC_PORT=8370
export DOCKER_HOST=tcp://127.0.0.1:2375
export APISERVER_PORT=8899
