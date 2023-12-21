_: {
  fileSystems = {
    "/mnt/data" = {
      device = "192.168.1.77:/mnt/user/data";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
    "/mnt/appdata" = {
      device = "192.168.1.77:/mnt/user/appdata";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
    "/mnt/docker" = {
      device = "192.168.1.77:/mnt/user/docker";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
    "/mnt/isos" = {
      device = "192.168.1.77:/mnt/user/isos";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };
}
