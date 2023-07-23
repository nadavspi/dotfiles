alias ls='nnn'
alias n='nnn'
set -gx NNN_FCOLORS '0000df310000000000000000'
set -gx NNN_OPTS 'aeA'
set -gx NNN_PLUG (string join ';' \
  'f:fzcd' \
  'h:fzhist' \
  'j:autojump' \
  'o:fzopen' \
  'p:preview-tui' \
)
