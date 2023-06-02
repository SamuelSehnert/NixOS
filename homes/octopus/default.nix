{ config, pkgs, ...}:
  (import ../common/user.nix)
  {
    inherit config pkgs;
    username = config.username;
    importList = [
    ];
    packages = with pkgs; [
      preconfigured

      calibre
    ];
  }
