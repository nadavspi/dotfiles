{...}: {
  imports = [
    ./adguard.nix
    ./exporters.nix
    ./gitea.nix
    ./grafana.nix
    ./tailscale.nix
  ];
}
