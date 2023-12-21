_: {
  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://nadavspi.cachix.org"
    "http://prague:5000?priority=1"
  ];

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nadavspi.cachix.org-1:RWw/jQTzs9mbgXNzL4ZKbEdqqlJ4dGoK9pF911QcUbk="
    "nix.nadav.is:2dIVRcE8LruUMK6MIe8LRTSH9pXM4br0zgFI3KmCjDk="
  ];
}
