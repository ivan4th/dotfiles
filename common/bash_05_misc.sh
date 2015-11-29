# old stuff

# shu () {
#   ~/progs/sshuttle/sshuttle -v --dns -r w 192.168.1.0/24 192.168.1.100/24
# }

# pickl () {
#   if [ -z "$1" ]; then
#     echo "must specify lesson name" 1>&2
#     return 1
#   fi
#   if ! echo "$1" | grep -q ':'; then
#     name="lesson:$1"
#   else
#     name="$1"
#   fi
#   # rm anything after a slash
#   name="$(echo -n "$name"|sed 's@/.*@@')"
#   # TBD: specify course name
#   cmscli --pull ssh://os --pluck="$name" &&
#   cmscli -v --add-lessons-to=zarniwoop_test_course --exact-name="$name"
# }


# fufl () {
#     if [ -z "$1" ]; then
#         echo "must specify SWF to fuck"
#         exit 1
#     fi
#     mkdir -p ~/rmme
#     cp "$1" ~/rmme/aaa.swf
#     ~/bin/flare ~/rmme/aaa.swf
#     if ! tty >& /dev/null; then
#         cat ~/rmme/aaa.flr
#     else
#         less ~/rmme/aaa.flr
#     fi
#     rm ~/rmme/aaa.{swf,flr}
# }

rmfasl () {
    find . -regex '.*\(fasl\|lx[0-9]*fsl\)' -print0 | xargs -0e rm -f
}

umedia () {
    grep /media/ /etc/mtab|cut -d' ' -f1|xargs umount
}
