settitle hamster

export KUBECONFIG=~/.kube/gitlab-admin.conf

cd ~/work/travelping/clusters/cluster-runner

function hdocker {
  ssh -L 2385:localhost:2375 h1 \
      'pkill socat; socat TCP-LISTEN:2375,reuseaddr,fork,bind=127.0.0.1 UNIX:/var/run/docker.sock'
}
