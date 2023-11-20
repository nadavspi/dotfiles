{
  description = "Fleek Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fleek.url = "https://flakehub.com/f/ublue-os/fleek/*.tar.gz";
  };

  outputs = { self, nixpkgs, home-manager, fleek, ... }@inputs: {
     packages.aarch64-darwin.fleek = fleek.packages.aarch64-darwin.default;
     packages.x86_64-linux.fleek = fleek.packages.x86_64-linux.default;

    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
    
      "nadavspi@stuttgart" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
              packages = [
                fleek.packages.x86_64-linux.default
              ];
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };

      "nadavspi@shanghai" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
              packages = [
                fleek.packages.x86_64-linux.default
              ];
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
      "nadavspi@fedora" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          ./home-manager/gui.nix 
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/home/${username}";
              packages = [
                fleek.packages.x86_64-linux.default
              ];
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
      "nadavspi@mac-mini-m2.local" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          ./home-manager/mac.nix
          { 
            home = rec {
              username = "nadavspi";
              homeDirectory = "/Users/${username}";
              packages = [
                fleek.packages.aarch64-darwin.default
              ];
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };

      "spiegeln@C02DP0G0MD6V" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin; 
        extraSpecialArgs = { inherit inputs; }; 
        modules = [
          ./home-manager
          { 
            home = rec {
              username = "spiegeln";
              homeDirectory = "/Users/${username}";
              packages = [
                fleek.packages.x86_64-darwin.default
              ];
            };
          }
          ({
           nixpkgs.overlays = [];
          })

        ];
      };
      
    };
  };
}
