{ config, lib, pkgs, ... }@extras: {

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        initrd = {
            luks.devices.luksroot = {
                device = "/dev/disk/by-label/CRYPT"; 
                preLVM = true;
                allowDiscards = true;
            };
            # nixos.wiki/wiki/Full_Disk_Encryption
            availableKernelModules = [ "aesni_intel" "cryptd" ];
        };
        kernelPackages = pkgs.linuxPackages_latest;

        # filefrag -v /swapfile | awk '{if($1=="0":"){print $4}}'
        kernelParams = [ "resume=/swapfile" "resume_offset=8724480" ];
    };

    swapDevices = [{
        device = "/swapfile";
        size = 1024 * extras.machine.swapSize;
    }];
}
