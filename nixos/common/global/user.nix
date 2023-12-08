{pkgs, ...}: {
  security.sudo.wheelNeedsPassword = false;
  users.users.nadavspi = {
    isNormalUser = true;
    description = "nadavspi";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7z7HX39Yr8x7e67suEouRH8NVZ7qcXQmQ7lc54BDfv"
    ];
    shell = pkgs.zsh;
  };
}
