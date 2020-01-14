if [ "$(uname)" == "Darwin" -a -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME="$HOME/virtualenvs"
    mkdir -p "$WORKON_HOME"
    export WORKON_HOME="${HOME}/virtualenvs"
    export PROJECT_HOME="${HOME}/work/python"
    export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
    export VIRTUALENVWRAPPER_VIRTUALENV="/usr/local/bin/virtualenv"
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages"

    . /usr/local/bin/virtualenvwrapper.sh
fi
