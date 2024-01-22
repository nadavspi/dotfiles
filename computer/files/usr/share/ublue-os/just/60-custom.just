USER := env_var('USER')
HOST := env_var('HOSTNAME')

# Apply home manager config
apply:
    #!/usr/bin/env bash
    set -euo pipefail
    cd ~/src/dotfiles
    nix run --impure home-manager/master -- -b bak switch --flake .#{{ USER }}@{{ HOST }}

latest:
    #!/usr/bin/env bash
    set -euo pipefail
    cd ~/src/dotfiles/
    git pull --autostash
    nix run --impure home-manager/master -- -b bak switch --flake .#{{ USER }}@{{ HOST }}

dotfiles-clone:
    #!/usr/bin/env bash
    set -euo pipefail
    dir=~/src/dotfiles
    if [ -d "$dir" ]; then
      echo "$dir already exists."
      exit
    fi
    mkdir -p ~/src
    cd ~/src
    git clone --recursive houston.nadav.is:/srv/git/dotfiles.git

firstboot hostname: dotfiles-clone
    chsh -s /usr/bin/zsh
    curl https://github.com/nadavspi.keys | tee -a ~/.ssh/authorized_keys
    xdg-settings set default-web-browser org.mozilla.firefox.desktop

rebase-signed:
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/nadavspi/nadavspi-ublue:latest

import '100-bling.just'
