{ config, pkgs, ... }: {
  imports = [
    ../../common
    ./openssh.nix
  ];
}
