export NNN_FCOLORS=0000df310000000000000000
export NNN_OPTS=aeAH

local plugins=(
  'a:personal/ag'
  'e:-!sudo -E vim "$nnn"*'
  'f:personal/fzfind'
  'j:autojump'
  'o:fzplug'
  'p:preview-tui'
)
export NNN_PLUG=${(j.;.)plugins}

# cd on quit
# https://github.com/jarun/nnn/tree/master/misc/quitcd
n ()
{
  # Block nesting of nnn in subshells
  [ "${NNNLVL:-0}" -eq 0 ] || {
    echo "nnn is already running"
      return
  }

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  command nnn "$@"

  [ ! -f "$NNN_TMPFILE" ] || {
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  }
}

