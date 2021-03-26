settitle vppt

export DOCKER_HOST=tcp://127.0.0.1:2385

cd ~/work/travelping/vpp-tcp-test

function b {
  ssh -t h1 'cd vpp; time buildctl --addr tcp://127.0.0.1:1234 build --frontend dockerfile.v0 --local context=. --local dockerfile=extras/docker --opt filename=Dockerfile.devel --opt target=final-stage --output type=docker,name=ivan4th/upf|docker load'
}

function st {
  ./docker-start.sh "${1:-ivan4th/upf}"
}

function bst {
  b && st
}

function tpr {
  docker exec -it vpptest /test.sh
}

function tht {
  docker exec -it vpptest /test.sh 80
}
