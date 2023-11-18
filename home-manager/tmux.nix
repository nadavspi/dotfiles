{ pkgs, ... }:
let
in
{

  home.packages = with pkgs; [
    lsof
  ];

  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    plugins = with pkgs;
      [
        tmuxPlugins.tmux-fzf
      ];
    sensibleOnTop = false;
    extraConfig = ''
      set -g prefix C-a
      bind C-a send-prefix
      unbind C-b

      set -g mouse on

      set-option -g focus-events on
      set -g status-position top
      setw -g mode-keys vi
      set -s escape-time 0
      set -g renumber-windows on
      set-option -g base-index 1
      setw -g pane-base-index 1

      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded .tmux.conf"

      bind-key b set-option status

      bind c new-window -c "#{pane_current_path}"

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

# don't prompt to kill 
      bind-key & kill-window
      bind-key x kill-pane

# resizing panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
    '';
  };
}
