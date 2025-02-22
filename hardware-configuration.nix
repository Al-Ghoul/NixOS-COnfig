{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3fff6d76-0107-4fd9-b95e-69c90511b671";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F379-C92B";
    fsType = "vfat";
  };

  fileSystems."/mnt/HardDriveOne" = {
    device = "/dev/disk/by-uuid/01D7BE88A6C1AFE0";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000"];
  };

  fileSystems."/mnt/HardDriveTwo" = {
    device = "/dev/disk/by-uuid/5c7ff1cc-7911-465f-8662-53e3ec23c0f0";
    fsType = "ext4";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
