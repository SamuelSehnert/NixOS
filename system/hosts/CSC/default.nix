{ config, pkgs, ... }: {
    imports = [
        ../../common
        ./audio.nix
        ./graphical.nix
        ./power.nix
    ];

    hardware.cpu.intel.updateMicrocode = true;
}
