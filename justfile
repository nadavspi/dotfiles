import "cli/justfile"

USER := env_var('USER') 
LOCALHOST := `uname -n`

# Sync dotfiles and apply home manager config
latest:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles/
  git pull --autostash
  nix run home-manager/master -- -b bak switch --flake .#{{USER}}@{{LOCALHOST}}

# Apply home manager config 
apply:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles
  nix run home-manager/master -- -b bak switch --flake .#{{USER}}@{{LOCALHOST}}

nixos:
  sudo nixos-rebuild switch --flake .#{{LOCALHOST}}

nixos-deploy host:
  nixos-rebuild switch --flake .#{{host}} \
    --no-build-nix \
    --use-remote-sudo \
    --build-host {{host}} \
    --target-host {{host}}

update-remote:
  #!/usr/bin/env bash
  set -euo pipefail
  cd ~/src/dotfiles
  git checkout -b main
  git remote rm origin
  git remote add origin houston.nadav.is:/srv/git/dotfiles.git
  git branch --set-upstream-to=origin/main main
  git remote add origin houston.nadav.is:/srv/git/dotfiles.git
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

cachix:
  cachix use nix-community

age-private-key-save:
  op read "op://Personal/dotfiles age key/password" > ~/src/dotfiles/.age-private-key.txt

age-private-key-copy host:
  scp .age-private-key.txt {{host}}:~/src/dotfiles/.age-private-key.txt

computer: computer-build computer-run
computer-build: 
  podman build . -f Containerfile.computer -t pc-test
computer-run:
  podman run -it computer-test zsh
  
cli: cli-build cli-run
cli-build: 
  podman build . -f Containerfile.cli -t cli-test
cli-run:
  podman run -it cli-test zsh

ephemeral:
  distrobox ephemeral --image ghcr.io/nadavspi/cli:latest -H ~/.home/sandbox
