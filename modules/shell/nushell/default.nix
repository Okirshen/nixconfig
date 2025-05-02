{ lib, primaryUser, confDir, config, pkgs, ... }:

let
  cfg = config.ncfg.shell.nushell;
in
{
  options.ncfg.shell.nushell = {
    enable = lib.mkEnableOption "Nushell";
  };

  config = lib.mkIf cfg.enable
    {
      users.defaultUserShell = pkgs.nushell;
      home-manager.users.${primaryUser} = { config, ... }: {
        programs = {
          nushell = {
            enable = true;
            extraConfig = ''
              let carapace_completer = {|spans|
              carapace $spans.0 nushell $spans | from json
              }
              
              $env.config = {
                  completions: {
                      case_sensitive: false
                      quick: true
                      partial: true
                      algorithm: "fuzzy"
                      external: {
                          enable: true
                          completer: $carapace_completer
                        }
                    }
                }
                $env.PATH = ($env.PATH | 
                split row (char esep) |
                prepend /home/myuser/.apps |
                append /usr/bin/env
                )
            '';
            shellAliases = {
                cd = "z";
                ls = "lsd";
                update-config = "nixos-rebuild switch --use-remote-sudo --flake ${confDir}";
                nv = "nvim";
                la = "ls -a";
                ll = "ls -l";
                lla = "ls -a -l";
              };
          };
        };
      };
    };
}
