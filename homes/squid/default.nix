{ config, pkgs, ... }:
(import ../common/user.nix)
{
  inherit config pkgs;
  username = config.username;
  importList = [
    ./foot.nix
    ./sway.nix
  ];
  userPackages = with pkgs; [
    firefox
    calibre
  ];
}
