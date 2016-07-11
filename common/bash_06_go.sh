[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export I4_GO_VERSION=go1.6.2
# gvm use "$I4_GO_VERSION" >& /dev/null

export GOPATH="$HOME/wbdev/go:$GOPATH"
export PATH="$PATH:$HOME/wbdev/go/bin"
