{inputs, ...}: let
  inherit (inputs) neovim-nightly-overlay;
in {
  nixpkgs.overlays = [neovim-nightly-overlay.overlay];
}
