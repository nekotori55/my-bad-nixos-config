{ pkgs, ... }:
{
  # Gamemode
  programs.gamemode.enable = true;

  # Steam
  programs.steam = {
    enable = true; # Couldn't install through home-manager lol cuz need some system stuff
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
}
