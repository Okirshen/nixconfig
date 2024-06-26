{ pkgs, primaryUser, machineName, ... }:

{
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://crane.cachix.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "crane.cachix.org-1:8Scfpmn9w+hGdXH/Q9tTLiYAE/2dnJYRJP7kl80GuRk="
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
        waybar.enable = true;
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


  boot.supportedFilesystems = [ "ntfs" ];

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
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };

    displayManager.sddm.enable = true;
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      xkb = {
        layout = "us,il";
        options = "grp:win_space_toggle";
      };
    };
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
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
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    xone.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    nerdfonts
    twemoji-color-font
  ];

  environment.systemPackages = with pkgs; [
    vim
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
