USER := env_var('USER')
HOST := env_var('HOSTNAME')
# Sync dotfiles and apply home manager config
latest:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles/
  git pull --autostash
  nix run --impure home-manager/master -- -b bak switch --flake .#{{USER}}@{{HOST}}

# Apply home manager config 
apply:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles
  nix run --impure home-manager/master -- -b bak switch --flake .#{{USER}}@{{HOST}}

