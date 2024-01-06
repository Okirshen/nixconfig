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
        builtins.mapAttrs (machineName: machineConfig:
          let
            specialArgs = {
              primaryUser = "okirshen";
              confDir = "/home/okirshen/.nixconfig";
              inherit machineName;
            };
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
              overlays = import ./overlays.nix;

              config.permittedInsecurePackages = [ "python-2.7.18.6" "electron-24.8.6" ];
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            inherit pkgs;
            inherit specialArgs;

            modules = [
              ./modules
              ./common/configuration.nix
              "${machineConfig}/configuration.nix"
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${specialArgs.primaryUser} = import ./common/home.nix;
              }
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${specialArgs.primaryUser} = import "${machineConfig}/home.nix";
              }
            ];
          }
        );
    in
    {
      nixosConfigurations = machines {
        okirshen-laptop = ./hosts/laptop;
        okirshen-desktop = ./hosts/desktop;
      };
    };
}
