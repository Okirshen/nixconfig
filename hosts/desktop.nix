{ config, pkgs, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8812au ];
}