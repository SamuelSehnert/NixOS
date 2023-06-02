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
    kernelParams =
      if extras.machine.hibernate.enable then
        [ "resume=/swapfile" "resume_offset=${toString extras.machine.hibernate.resume-offset}" ]
      else [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/swapfile";
    size = 1024 * extras.machine.swapSize;
  }];
}
