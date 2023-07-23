alias ls='nnn'
set -gx NNN_FCOLORS '0000df310000000000000000'
set -gx NNN_OPTS 'aeA'
set -gx NNN_PLUG (string join ';' \
  'a:personal/ag' \
  'e:-!sudo -E vim "$nnn"*' \
  'f:personal/fzfind' \
  'j:autojump' \
  'o:fzplug' \
  'p:preview-tui' \
)
