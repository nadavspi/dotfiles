# home-manager switch --flake .#nadavspi
{
  description = "nadavspi/dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }:
    
   let 
     mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
       pkgs = nixpkgs.legacyPackages.${args.system or "x86_64-linux"};
       modules = [
         ./home-manager/home.nix
         ./home-manager/dotfiles.nix
         { 
           home = rec {
             username = "nadavspi";
             homeDirectory = "/home/${username}";
           };
         }
       ];
     } // args);

   systems = [
      { system = "x86_64-linux"; }
      { system = "x86_64-darwin"; }
    ];

   in {
   homeConfigurations.server = mkHomeConfiguration {
     extraSpecialArgs = rec {
       withGUI = false;
       username = "nadavspi";
       homeDirectory = "/home/${username}";
       dotfiles = "${homeDirectory}/src/dotfiles";
     };
   };
  };
}
