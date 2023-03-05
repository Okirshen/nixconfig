{ nixpkgs, hyprland, home-manager, nixos-hardware, primaryUser }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      godot-FBX2glTF = pkgs.callPackage ../pkgs/godot-FBX2glTF { };
    };

    config.permittedInsecurePackages = [
      "python-2.7.18.6"
    ];

    overlays = [
      (self: super: {
        aseprite-unfree = super.aseprite-unfree.overrideAttrs (attrs: {
          version = "1.3-beta21";
          postPatch = "";
        });
        godot_4 = super.godot_4.override (godotOld: {
          libX11 = godotOld.libX11.overrideAttrs (attrs: {
            version = "1.8.4";
            src = super.fetchurl {
              url = "mirror://xorg/individual/lib/libX11-1.8.4.tar.xz";
              sha256 = "sha256-yaKHpa76mATOPPr89Rb+lu0/fo5FwOLuWehMhnV99Rg=";
            };
          });
        });
      })
    ];
  };

  inherit (nixpkgs) lib;
in {
  nixos = lib.nixosSystem {
    inherit system pkgs;

    specialArgs = {
      inherit primaryUser;
      hostname = "nixos";
    };

    modules = [
      hyprland.nixosModules.default
      {programs.hyprland = { 
        enable = true;
      };}
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        imports = [ ./home ];
      }
      ./configuration.nix
      ../hardware-configuration.nix
      ] ++ (with nixos-hardware.nixosModules; [ common-pc-ssd common-gpu-amd common-cpu-intel ]);
  };
}