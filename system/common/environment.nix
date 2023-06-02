{ config, lib, pkgs, ... }@extras: {
  environment = {
    sessionVariables = { };
    systemPackages = with pkgs; [
      git
      vim
    ];
  };
}
