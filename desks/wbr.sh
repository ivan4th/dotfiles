settitle wb-rules
if [ ! -d /tmp/edit ]; then
    mkdir /tmp/edit
    cp ~/work/contactless/wb-rules/*.js /tmp/edit
fi
cd ~/work/contactless/wb-rules
alias r="go build && ./wb-rules -debug -editdir /tmp/edit /tmp/edit -debug"
