{ pkgs, primaryUser, machineName, ... }:

{
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  users.users.${primaryUser} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "libvirtd"
      "wheel"
      "input"
      "docker"
      "dialout"
    ];
  };

  ncfg = {
    shell = {
      wezterm.enable = true;
    };
    wm.hyprland.enable = true;
    programs = {
      misc = {
        swaylock.enable = true;
      };
    };
  };


  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking.hostName = machineName;
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jerusalem";
  # i18n.defaultLocale = "en_US.UTF-8";

  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh.enable = true;
    gamemode.enable = true;
    steam.enable = true;
    gamescope.enable = true;
    dconf.enable = true;
    udevil.enable = true;
    virt-manager.enable = true;
  };

  services = {
    flatpak.enable = true;
    devmon.enable = true;
    xserver = {
      enable = true;
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
      };
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
      layout = "us,il";
      xkbOptions = "grp:win_space_toggle";
    };
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security = {
    rtkit.enable = true;
    doas = {
      enable = true;
      extraRules = [{
        users = [ primaryUser ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
  };

  virtualisation = {
    libvirtd.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    xone.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
    twemoji-color-font
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    bottom
    tree
    killall
    pciutils
    dash
    lsd
    gcc
    bat
    nixd
    fd
    cmake
    nixpkgs-fmt
    ripgrep
  ];

  # pls dont fuck with
  system.stateVersion = "22.11"; # pls
}
