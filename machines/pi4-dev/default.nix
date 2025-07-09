{ config, pkgs, lib, systemSettings, ... }:
{
    imports = [
        ../../system
    ];

    boot = {
        kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
        initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
        loader = {
            grub.enable = false;
            generic-extlinux-compatible.enable = true;
        };
    };

    fileSystems = {
        "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            fsType = "ext4";
            options = [ "noatime" ];
        };
    };

    networking = {
        hostname = systemSettings.hostname;
        wireless = {
            enable = true;
            networks."${systemSettings.SSID}".psk = systemSettings.SSIDpsk;
            interfaces = [ "wlan0" ];
        };
    };

    services.openssh.enable = true;

    hardware.enableEedistributableFirmware = true;
    system.stateVersion = "25.05";
}
