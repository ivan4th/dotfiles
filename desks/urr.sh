settitle urr

export DOCKER_HOST=tcp://127.0.0.1:2385

cd ~/work/travelping/urr

function b {
  ssh -t h1 'cd vpp; time buildctl --addr tcp://127.0.0.1:1234 build --frontend dockerfile.v0 --local context=. --local dockerfile=extras/docker --opt filename=Dockerfile.devel --opt target=final-stage --output type=docker,name=ivan4th/upf|docker load'
}

function br {
  ssh -t h1 'cd vpp; time buildctl --addr tcp://127.0.0.1:1234 build --frontend dockerfile.v0 --local context=. --local dockerfile=extras/docker --opt filename=Dockerfile --opt target=final-stage --output type=docker,name=ivan4th/upf|docker load'
}
