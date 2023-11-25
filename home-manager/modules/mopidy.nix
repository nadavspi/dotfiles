{ pkgs, ... }: {

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [ mopidy-spotify mopidy-mpd mopidy-mpris ];
    settings = {
      file = {
        media_dirs = [ "/mnt/data/media/music" ];
        follow_symlinks = true;
        excluded_file_extensions = [ ".html" ".zip" ".jpg" ".jpeg" ".png" ];
      };

      spotify = {
        client_id = "c6d452bd-9800-43b3-8093-24ad8c352f9d";
        client_secret = "4_mg1_CaxmFj1VQZ4Ew8STYn_1lveFDavZnBkaPFHwg=";
      };
    };
  };
}
