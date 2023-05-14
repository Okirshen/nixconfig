{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland?rev=2df0d034bc4a18fafb3524401eeeceaa6b23e753";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixneovim.url = "github:nixneovim/nixneovim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, hyprland, nixos-hardware, nixneovim, home-manager, ... }:
    let 
      primaryUser = "okirshen";
    in
    {
      nixosConfigurations = import ./hosts {
        inherit nixpkgs hyprland home-manager nixos-hardware nixneovim primaryUser;
    };
  };
}