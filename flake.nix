{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, hyprland, nixos-hardware, home-manager, ... }:
    let 
      primaryUser = "okirshen";
    in
    {
      nixosConfigurations = import ./hosts {
        inherit nixpkgs hyprland home-manager nixos-hardware primaryUser;
    # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    #   modules = [
    #     ./configuration.nix
    #     ./hardware-configuration.nix
    #     hyprland.nixosModules.default
    #     {programs.hyprland = { 
    #       enable = true;
    #     };}
    #     home-manager.nixosModules.home-manager {
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;
    #       imports = [ ./home ];
    #     }
    #   ] ++ (with nixos-hardware.nixosModules; [ common-pc-ssd common-gpu-amd common-cpu-intel ]);
    };
  };
}