{ config, pkgs, ... }: {
  imports = [
    ../../common
    ./boot.nix
    ./audio.nix
    ./graphical.nix
    ./power.nix
  ];
}
