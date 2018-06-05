if hash ag 2>/dev/null; then
  export TAG_SEARCH_PROG=ag  # replace with rg for ripgrep
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null; }
  alias ag=tag  # replace with rg for ripgrep
fi

alias agm="ag --make "
alias agx="ag --xml "
alias agj="ag --java "
alias agc="ag --cpp --cc "
alias agh="ag --hh "
