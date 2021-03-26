# based on https://github.com/jamesob/desk

[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

if [ "$HOSTTYPE" = "arm" ]; then
   PS1="(wbch)$PS1"
elif [ "$HOSTNAME" = "wbdevenv" ]; then
   PS1="(wbdev)$PS1"
fi

function d {
    if [[ ! ${1} ]]; then
        echo no desk specified 1>&2
        return 1
    fi
    if [[ ${1} == list ]]; then
      ( cd "${bashrc_dir}/../desks" && ls *.sh | sed 's/\.sh$//' )
      return 0
    fi
    DESK_NAME="$1" DESK_ENV="${bashrc_dir}/../desks/${1}.sh" exec "$SHELL"
}

function sd {
  local desk_name="${1:-${DESK_NAME}}"
  if [[ ! ${desk_name} ]]; then
    echo >&2 "No desk selected or specified"
  fi
  local desk_path="${bashrc_dir}/../desks/${desk_name}.sh"
  echo "*** ${desk_path} ***"
  cat "${desk_path}"
}

function edesk {
  local desk_name="${1:-${DESK_NAME}}"
  if [[ ! ${desk_name} ]]; then
    echo >&2 "No desk selected or specified"
  fi
  local desk_path="${bashrc_dir}/../desks/${desk_name}.sh"
  "${EDITOR}" "${desk_path}"  
}

# based on https://github.com/jamesob/desk/blob/master/shell_plugins/bash/desk
function _d {
    PREFIX="${DESK_DIR:-$HOME/.desk}"
    DESKS="${DESK_DESKS_DIR:-$PREFIX/desks}"
    COMPREPLY=( $(compgen -W "${desks}" -- ${cur}) )
    cur=${COMP_WORDS[COMP_CWORD]}

    if [[ -d $DESKS ]]; then
        local desks=$(d list)
    else
        local desks=""
    fi
    COMPREPLY=( $(compgen -W "${desks}" -- ${cur}) )
}

complete -F _d d
