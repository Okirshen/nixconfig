{ lib, primaryUser, confDir, config, ... }:

let
  cfg = config.ncfg.programs.editor.neovimm;
in
{
  options.ncfg.programs.editor.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf cfg.enable
    {
      home-manager.users.${primaryUser} = { config, pkgs, ... }: {
        environment.systemPackages = pkgs.neovim;
        programs.wezterm = {
          enable = true;
        };

        xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${confDir}/modules/shell/wezterm/wezterm.lua";
        home.sessionVariables = {
          TERM = "wezterm";
        };
      };
    };
}
