{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/nadavspi/src/dotfiles/.age-private-key.txt";

  sops.secrets.k3s-token = { };
}
