{ pkgs, primaryUser, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  services.fprintd.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ primaryUser ];
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
