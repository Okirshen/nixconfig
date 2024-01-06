{ lib, primaryUser, confDir, config, ... }:

let
  cfg = config.ncfg.shell.wezterm;
in
{
  options.ncfg.shell.wezterm = {
    enable = lib.mkEnableOption "Wezterm";
  };

  config = lib.mkIf cfg.enable
    {
      home-manager.users.${primaryUser} = { config, ... }: {
        programs.wezterm = {
          enable = true;
        };

        xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${confDir}/modules/shell/wezterm/wezterm.lua";
      };
    };
}
