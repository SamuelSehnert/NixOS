{ config, lib, pkgs, ... }@extras: {
    networking = {
        hostName = extras.machine.hostname;
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
    }; 
    time.timeZone = "America/Los_Angeles";
}
