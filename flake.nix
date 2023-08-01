{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      machines =
        let
          primaryUser = "okirshen";
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
            overlays = import ./overlays.nix;

            config.permittedInsecurePackages = [ "python-2.7.18.6" ];
          };
        in
        builtins.mapAttrs
          (machineName: machineConfig:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = {
                inherit primaryUser;
                inherit machineName;
              };

              modules = [
                ./common/configuration.nix
                "${machineConfig}/configuration.nix"
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.${primaryUser} = import ./common/home.nix;
                }
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.${primaryUser} = import "${machineConfig}/home.nix";
                }
              ];
            }
          );
    in
    {
      nixosConfigurations = machines {
        okirshen-laptop = ./hosts/laptop;
        # okirshen-desktop = ./hosts/desktop/;
      };
    };
}
