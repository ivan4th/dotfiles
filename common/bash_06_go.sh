[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
gvm use go1.6.1 >& /dev/null

export GOPATH="$HOME/wbdev/go:$GOPATH"
export PATH="$PATH:$HOME/wbdev/go/bin"
