{...}: {
  imports = [
    ./adguard.nix
    ./exporters.nix
    ./grafana.nix
    ./k3s.nix
    ./nix-serve.nix
    ./tailscale.nix
  ];
}
