USER := env_var('USER')
HOST := env_var('HOSTNAME')
# Apply home manager config 
apply:
  #!/usr/bin/env bash
  set -euo pipefail
  nix run --impure home-manager/master -- -b bak switch --flake .#{{USER}}@{{HOST}}

