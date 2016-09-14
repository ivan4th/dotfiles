settitle kube
export KPATH=$HOME/work/kubernetes
export GOPATH=$KPATH
export PATH=$PATH:$HOME/go-tools/bin
export KUBERNETES_SRC_DIR=$KPATH/src/k8s.io/kubernetes
cd $KUBERNETES_SRC_DIR
export KUBERNETES_PROVIDER=local
alias kc="$KUBERNETES_SRC_DIR/cluster/kubectl.sh"

function ssrc {
    (
        cd "$KUBERNETES_SRC_DIR"
        if [ ! -f /tmp/lastSync ]; then
            # TBD: push current branch
            # TBD: delete test_tmp before that
            # TBD: sync stashes (and remove --exclude .git/refs/stash)
            git push -f vd:work/kubernetes/src/k8s.io/kubernetes test:test_tmp
            rsync -avz \
                  --filter=':- .gitignore' \
                  --exclude .git/objects --exclude .git/refs/stash \
                  --delete \
                  "$HOME"/work/kubernetes/src/k8s.io/kubernetes/ \
                  vd:work/kubernetes/src/k8s.io/kubernetes/
        elif [ -z "$(find . -cnewer /tmp/lastSync -type f |head -1)" ]; then
            echo "Everthing is up to date" 1>&2
            return 0
        else
            # FIXME: empty dirs are not synced by this
            # TBD: handle file removal
            comm -12 <(find . -cnewer /tmp/lastSync -type f|sed 's@^\./@@'|sort) \
                 <((git status --porcelain|sed 's/^.[^ ]* *//'; \
                    ssh vd "cd ~/work/kubernetes/src/k8s.io/kubernetes && git status --porcelain|sed 's/^.[^ ]* *//'")|sort) |
                xargs tar -cz |
                ssh vd tar -C /home/vagrant/work/kubernetes/src/k8s.io/kubernetes -xvz
        fi
        touch /tmp/lastSync
    )
}
