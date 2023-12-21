{pkgs, ...}: let
  fcitx5 = {
    addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-nord
    ];
  };
in {
  i18n.inputMethod = {
    enabled = "fcitx5";
    inherit fcitx5;
  };
}
