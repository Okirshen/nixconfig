{ config, lib, primaryUser, confDir, ... }:

let
  cfg = config.ncfg.programs.misc.waybar;
in
{
  options.ncfg.programs.misc.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable
    {
      home-manager.users.${primaryUser} = { config, pkgs, ... }: {
        programs.waybar = {
          enable = true;
          settings = {
            mainBar = {
              layer = "top";
              position = "top";
              height = 35;
              modules-left = [ "tray" "battery" "hyprland/workspaces" ];
              modules-center = [ "clock" ];
              modules-right = [ "custom/language" "network" "wireplumber" ];
              wireplumber = {
                format = "{volume} 󰕾";
              };
              battery = {
                format = "{capacity} {icon}";
                format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              };
              network = {
                format = "{essid} {icon}";
                format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
                on-click = "$TERM start nmtui";
              };
              # "custom/language" = { }
            };
          };
        };
      };
    };
}
