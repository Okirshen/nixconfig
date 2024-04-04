{ lib, primaryUser, confDir, config, pkgs, ... }:

let
  cfg = config.ncfg.programs.editors.neovim;
in
{
  options.ncfg.programs.editors.neovim = {
    enable = lib.mkEnableOption "Neovim";
    defaultEditor = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Configure neovim to be the default editor";
    };
  };

  config = lib.mkIf cfg.enable
    {
      home.packages = with pkgs; [
        pkgs.neovim
        nodePackages.prettier
      ];
      xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${confDir}/home/modules/programs/editors/neovim/nvim/";
      home.sessionVariables.EDITOR = lib.mkIf cfg.defaultEditor "nvim";
    };
}
