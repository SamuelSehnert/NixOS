{ config, lib, pkgs, ... }@extras: {
  networking = {
    hostName = extras.machine.hostname;
    networkmanager.enable = true;
  };
  time.timeZone = "America/Los_Angeles";
}
