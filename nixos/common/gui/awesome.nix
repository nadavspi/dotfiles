{pkgs, ...}: let
  awesomeGit = pkgs.awesome.overrideAttrs (previousAttrs: {
    version = "375d9d7";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "375d9d7";
      hash = "sha256-9cIQvuXUPu8io2Qs3Q8n2WkF9OstdaGUt/+0FMrRkXk=";
    };

    patches = [];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.windowManager.awesome = {
    enable = true;
    package = awesomeGit;
  };

  security.polkit.enable = true;

  services = {
    blueman.enable = true;
  };

  programs = {
    nm-applet.enable = true;
  };

  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
    feh
    flameshot
    kitty
    lxde.lxsession
    mpv
    pasystray
    pcmanfm
    redshift
    rofi
    xfce.xfce4-power-manager
  ];
}
