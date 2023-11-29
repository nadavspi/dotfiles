{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./home.nix ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = { allowUnfree = true; };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.git.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    #	  displayManager.gdm = {
    #		  enable = true;
    #		  wayland = true;
    #	  };
  };

  # services.xserver.desktopManager.mate.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.nadavspi = {
    isNormalUser = true;
    description = "nadavspi";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoB2mIjDjT89lSU+5nq4azV5yarJhMrc1pWEAwfqHg/J3LS2fskCWO/1EoUfSwlchXimQVADebjUhnfcBSzat5BMCBV+KD6Rj2NUai/1IQiaHaKdBQQjLblqUrHliL096MvApA1pO11O3/9Vc5T8UBWkQ44gRK3UdP9CSNAYBDs2hCIahuwle+Fo1irOiGI0df8T5/hWWfHU4j0Bh3usWtK8lCJHmJPDvCp7bYIW+69SgptKEn8ClTE41TvGh9POMxv7S5kSy3Ir93UDE6nXVk084GluJQUdV/F2Jnais9UlrtDOy4+X1QHqaqoDBWfqvBxBDqQgN8fUYLmAuTBvy1TC3X6xu5FyHpQVmLzD2DdGrYeJuGpgO6mkAUOh9q6n2RGFvT4priIS9z5AhQJBdHpaOP55GDOWQmLNJgHFsM3Nwwc/VkQ6mBF8bucrXz1DCgfRGEtbSqMIyV4DFgZBOWlAJRtDl0nRr9DMJROhUZLLM+x6tGFuBwuiHPznOQOAmlvecndX5vlOVy0Lo7E+8GJQ30IESkzTPwEQDEXm1X7GRWSVYUgnvFsMQe1CkbJ8085JshO/1UPGAjEF/QNjHxm5jnXlw/gOXepS7pAQ32KY0JgUFknQ3cqqnGsqjPg/NpGb8WtuZN4gfp6s18aIyIi9JmOH7EugiQ7XxoXDHlMw=="
    ];
    packages = with pkgs; [ firefox ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}