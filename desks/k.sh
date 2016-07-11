settitle kube
gvm use "$I4_GO_VERSION"
export KPATH=$HOME/work/kubernetes
export GOPATH=$KPATH
export PATH=$PATH:$HOME/go-tools/bin
export KUBERNETES_SRC_DIR=$KPATH/src/k8s.io/kubernetes
cd $KUBERNETES_SRC_DIR
export KUBERNETES_PROVIDER=local
alias kc=$KUBERNETES_SRC_DIR/cluster/kubectl.sh
