{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ckan
  ];


  xdg.configFile."hypr/host.conf".source = ./host.conf;
}
