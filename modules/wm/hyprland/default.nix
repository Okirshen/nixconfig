{ config, lib, primaryUser, confDir, ... }:

let
  cfg = config.ncfg.wm.hyprland;
in
{
  options.ncfg.wm.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable
    {
      programs.hyprland.enable = true;
      home-manager.users.${primaryUser} = { config, ... }: {
        xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${confDir}/modules/wm/hyprland/hyprland.conf";
      };
    };
}
