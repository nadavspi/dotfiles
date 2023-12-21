{
  inputs,
  outputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    extraSpecialArgs = {
      dotfiles = "/home/nadavspi/src/dotfiles";
    };
    useGlobalPkgs = true;
    users.nadavspi = import ../../../home-manager;
  };
}
