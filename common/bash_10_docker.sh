function ldock {
  export KUBE_RSYNC_PORT=8370
  #export DOCKER_HOST=tcp://127.0.0.1:2375
  export DOCKER_HOST="unix://$HOME/docker.sock"
  export APISERVER_PORT=8899
}

function dnano {
  docker exec -it "${1}" /bin/bash -c "apt-get update && apt-get install -y nano"
}

function ds {
  docker exec -it "${1}" /usr/bin/env TERM=xterm /bin/bash
}

function dsm {
  ds kube-master
}

function dsn {
  ds kube-node-${1:-1}
}
