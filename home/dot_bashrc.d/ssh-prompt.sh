#!/usr/bin/env bash
if [ -n "$SSH_TTY" ]; then
  gum confirm "Enter CLI container?" && cli enter || return
fi
