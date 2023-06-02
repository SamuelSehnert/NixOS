{ config, pkgs, ... }:
(import ../common/user.nix)
{
  inherit config pkgs;
  username = config.username;
  importList = [
    ./foot.nix
    ./sway.nix
  ];
  packages = with pkgs; [
    preconfigured
    firefox
  ];
}
