{ config, lib, pkgs, ... }: {
  services = {
    upower.enable = true;
    logind = {
      lidSwitch = "hybrid-sleep";
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
