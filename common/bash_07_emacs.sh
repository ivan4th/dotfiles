# emacsclient
if [[ ${I4SYSTYPE} == "macosx" ]]; then
  export EDITOR=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
fi
alias e="emacsclient -n"
