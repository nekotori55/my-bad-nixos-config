{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.gaming.enable {
    # Gamemode
    programs.gamemode.enable = true;

    # Steam
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraLibraries = (
          pkgs: with pkgs; [
            openssl
            nghttp2
            libidn2
            rtmpdump
            libpsl
            curl
            krb5
            keyutils
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
          ]
        );
      };
    };
  };
}
