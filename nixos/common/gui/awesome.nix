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
    gnome.gnome-keyring
    kitty
    mpv
    pasystray
    pcmanfm
    polkit_gnome
    redshift
    rofi
    xfce.xfce4-power-manager
  ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
