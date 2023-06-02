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
      availableKernelModules = [ "aesni_intel" "cryptd" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];

    # filefrag -v /swapfile | awk '{if($1=="0":"){print $4}}'
    kernelParams = [ "resume=/swapfile" "resume_offset=8724480" ];
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
    size = 1024 * 8;
  }];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
