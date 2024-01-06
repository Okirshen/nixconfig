{ config, lib, primaryUser, confDir, ... }:

let
  cfg = config.ncfg.programs.misc.swaylock;
in
{
  options.ncfg.programs.misc.swaylock = {
    enable = lib.mkEnableOption "Swaylock";
  };

  config = lib.mkIf cfg.enable
    {
      security.pam.services.swaylock = { };

      home-manager.users.${primaryUser} = { config, pkgs, ... }: {
        programs.swaylock = {
          enable = true;
          package = pkgs.swaylock-effects;
          settings = {
            # image = "${confDir}/background.png";
            screenshots = true;
            indicator = true;
            grace = 5;
            fade-in = 0.2;
            effect-blur = "7x5";
            effect-vignette = "0.5:0.5";
            indicator-radius = 200;
            indicator-thickness = 10;
            ring-color = "bb00cc";
            clock = true;
          };
        };
      };
    };
}
