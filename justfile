USER := env_var('USER') 
HOST := `uname -n`

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

update-remote:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles
  git co -b main
  git remote rm origin
  git remote add origin houston:/srv/git/dotfiles.git
  git branch --set-upstream-to=origin/main main
  git pull origin main --rebase --autostash
