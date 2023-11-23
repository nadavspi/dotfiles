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
  git checkout -b main
  git remote rm origin
  git remote add origin houston.nadav.is:/srv/git/dotfiles.git
  git branch --set-upstream-to=origin/main main
  git pull origin main --rebase --autostash

install-1password-cli:
  ARCH="amd64" && \
        wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.23.0/op_linux_${ARCH}_v2.23.0.zip" -O op.zip && \
        unzip -d op op.zip && \
        sudo mv op/op /usr/local/bin && \
        rm -r op.zip op && \
        sudo groupadd -f onepassword-cli && \
        sudo chgrp onepassword-cli /usr/local/bin/op && \
        sudo chmod g+s /usr/local/bin/op
