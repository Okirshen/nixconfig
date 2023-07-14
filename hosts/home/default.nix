{ ... }:

{
  home-manager.users.okirshen = { pkgs, ... }: {


    home.packages = with pkgs; [
      helvum
      ghc
      ghcid
      haskell-language-server
      cabal-install
      freecad
      ncspot
      bacon
      peek
      kdenlive
      postman
      dbeaver
      cheat
      tldr
      git-ignore
      ngrok
      python310Packages.python-lsp-server
      python3
      pcmanfm
      sxiv
      zellij
      jellyfin-media-player
      thefuck
      gitAndTools.gh
      mpv
      rustup
      obs-studio
      pfetch
      neofetch
      btop
      prismlauncher
      # kicad
      logisim-evolution
      stremio
      godot_4
      aseprite-unfree
      spotify
      ark
      # blender
      godot-FBX2glTF
      libreoffice
      obsidian
      wofi
      hyprpaper
      # discord
      webcord
      pavucontrol
      ncdu
      grim
      slurp
      wl-clipboard
      heroic
      tokei
      ckan
      ripgrep
      nixfmt
      neovim
    ];

    home.stateVersion = "22.11";
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "image/png" = [
        "sxiv.desktop"
        "gimp.desktop"
      ];
      "inode/directory" = "pcmanfm.desktop";
    };
    xdg.configFile."hypr".source = ./hypr;
    xdg.configFile."zellij".source = ./zellij;
    xdg.configFile."nvim".source = ./nvim;
    home.sessionVariables = { 
      TERM = "kitty";
      NIXOS_OZONE_WL = "1";
    };

    services = {
      gpg-agent.enable = true;
      mako = {
        enable = true;
        output = "DP-4";
        borderRadius = 10;
        backgroundColor = "#282a36";
        borderSize = 0;
      };
    };
    programs = {
      direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
      };
      gpg.enable = true;
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 35;
            modules-left = [ "wlr/workspaces" "tray" "cpu" ];
            modules-center = [ "clock" ];
            modules-right = [ "pulseaudio" ];
          };
        };
      };
      vscode = {
        enable = true;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [ 
          matklad.rust-analyzer
          dracula-theme.theme-dracula 
          eamodio.gitlens
          file-icons.file-icons
          asvetliakov.vscode-neovim
        ];      
        userSettings = { "workbench.colorTheme" = "Dracula"; };
      };
      firefox.enable = true;
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        enableVteIntegration = true;
        autocd = true;
        dotDir = ".config/zsh";
        shellAliases = {
          cd = "z";
          ls = "lsd";
          update-config = "doas nixos-rebuild switch --flake ~/.nixconfig/";
          sudo = "doas";
          nv = "nvim";
        };
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          aws.style = "bold #ffb86c";
          cmd_duration.style = "bold #f1fa8c";
          directory.style = "bold #50fa7b";
          hostname.style = "bold #ff5555";
          git_branch.style = "bold #ff79c6";
          git_status.style = "bold #ff5555";
          username = {
            format = "[$user]($style) on ";
            style_user = "bold #bd93f9";
          };
          character = {
            # success_symbol = "[λ](bold #f8f8f2)";
            # error_symbol = "[λ](bold #ff5555)";
          };
        };
      };
      # gh = {
        # enable = true;
        # package = pkgs.gitAndTools.gh;
      # };
      kitty = {
        enable = true;
        font = {
          package = pkgs.nerdfonts;
          name = "FiraCode Nerd Font";
        };

        settings = {
          disable_ligatures = "cursor";
          enable_audio_bell = "false";

          foreground = "#f8f8f2";
          background = "#282a36";
          selection_foreground = "#ffffff";
          selection_background = "#44475a";

          background_opacity = "0.5";

          url_color = "#8be9fd";
          color0 = "#21222c";
          color8 = "#6272a4";
          color1 = "#ff5555";
          color9 = "#ff6e6e";
          color2 = "#50fa7b";
          color10 = "#69ff94";
          color3 = "#f1fa8c";
          color11 = "#ffffa5";
          color4 = "#bd93f9";
          color12 = "#d6acff";
          color5 = "#ff79c6";
          color13 = "#ff92df";
          color6 = "#8be9fd";
          color14 = "#a4ffff";
          color7 = "#f8f8f2";
          color15 = "#ffffff";
          cursor = "#f8f8f2";
          cursor_text_color = "#282a36";
          active_tab_foreground = "#282a36";
          active_tab_background = "#f8f8f2";
          inactive_tab_foreground = "#282a36";
          inactive_tab_background = "#6272a4";
          mark1_foreground = "#282a36";
          mark1_background = "#ff5555";
          active_border_color = "#f8f8f2";
          inactive_border_color = "#6272a4";
        };
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      helix = {
        enable = true;
        settings = {
          theme = "dracula";
          editor = {
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            lsp.display-messages = true;
          };
        };
      };
      # nixneovim = {
      #   enable = true;
      #   defaultEditor = true;
      #   viAlias = true;
      #   vimAlias = true;
      #   colorschemes.dracula.enable = true;
      #   plugins = {
      #     lsp = {
      #       enable = true;
      #       rust-analyzer.enable = true;
      #     };
      #     treesitter = {
      #       enable = true;
      #       indent = true;
      #     };
      #   };
      #   extraPlugins = with pkgs.vimPlugins; [
      #     yuck-vim
      #     telescope-nvim
      #     alpha-nvim
      #     nvim-colorizer-lua
      #     nvim-web-devicons
      #     nvim-treesitter
      #     nvim-cmp
      #     cmp-nvim-lsp
      #     cmp-path
      #     cmp-cmdline
      #     gitsigns-nvim
      #     nvim-autopairs
      #     comment-nvim
      #     dracula-nvim
      #   ];
      # };
    };
  };
}
