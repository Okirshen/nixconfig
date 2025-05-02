[
  # (self: super: {
  #   aseprite-unfree = super.aseprite-unfree.overrideAttrs (attrs: {
  #     version = "1.3.10.1";
  #     src = super.fetchFromGitHub {
  #       owner = "aseprite";
  #       repo = "aseprite";
  #       rev = "v1.3.10.1";
  #       fetchSubmodules = true;
  #       hash = "sha256-KwZrgoD1dPpOYI1manZh31r53wo+rY1NKsge1KJiFJA=";
  #     };
  #     postPatch = "";
  #   });
  # })
  (self: super: {
    steam = super.steam.override {
      extraPkgs = (pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ]);
    };
  })
]
