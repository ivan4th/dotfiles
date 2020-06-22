function tshl {
  tsh logout || true
  tsh login --proxy teleport.cennso.com &&
    if [[ ${1:-} ]]; then
      tsh login --proxy teleport.cennso.com "${1}"
    fi
}
