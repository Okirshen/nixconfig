# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, primaryUser, ... }:

{
  imports = [];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Dublin";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.binsh = "${pkgs.dash}/bin/dash";
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.syncthing = {
        enable = true;
        user = "${primaryUser}";
        dataDir = "/home/${primaryUser}/Projects";    # Default folder for new synced folders
        configDir = "/home/${primaryUser}/Projects/.config/syncthing";   # Folder for Syncthing's settings and keys
    };

  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "${primaryUser}" ];
    keepEnv = true;
    persist = true;  
  }];

  services.xserver.enable = true;
  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver = {
    layout = "us,il";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle,caps:escape";
  };

  services.printing.enable = true;

  services.gnome.gnome-keyring.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${primaryUser} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    twemoji-color-font
  ];



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    helix
    dash
    gcc
    bat
    lsd
    unzip
    nil
    fd
    nixpkgs-fmt
    bottom
    tree
    killall
  ];

  services.xserver.libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };

      # disabling touchpad acceleration
      touchpad = {
        accelProfile = "flat";
      };
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.autoUpgrade.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
