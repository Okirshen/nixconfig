{ pkgs, ... }:

{
  home.packages = with pkgs; [
  ];


  xdg.configFile."hypr/host.conf".source = ./host.conf;
}
