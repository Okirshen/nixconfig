[
  (self: super: {
    aseprite-unfree = super.aseprite-unfree.overrideAttrs (attrs: {
      version = "1.3-rc6";
      postPatch = "";
    });
  })
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
