{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:okirshen/Hyprland";
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
    };
  };
}
