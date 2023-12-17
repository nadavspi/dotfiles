#!/usr/bin/env bash
#
is_osx() {
	local platform=$(uname)
	[ "$platform" == "Darwin" ]
}
if is_osx; then
  tmux bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
  tmux bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
  tmux bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
else
  tmux bind -T copy-mode-vi v send -X begin-selection
  tmux bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
  tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel
fi
