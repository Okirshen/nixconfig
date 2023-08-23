{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
  ];


  xdg.configFile."hypr/host.conf".source = ./host.conf;
}
