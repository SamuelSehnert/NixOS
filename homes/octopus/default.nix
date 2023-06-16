{ config, pkgs, ... }:
(import ../common/user.nix)
{
  inherit config pkgs;
  username = config.username;
  importList = [
  ];
  userPackages = with pkgs; [
    calibre
  ];
}
