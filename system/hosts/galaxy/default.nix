{ config, pkgs, ... }: {
  imports = [
    ../../common
    ./boot.nix
    ./openssh.nix
  ];
}
