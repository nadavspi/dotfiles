{ inputs, outputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      dotfiles = "/home/nadavspi/src/dotfiles";
    };
    users = { nadavspi = import ../../home-manager; };
  };
}
