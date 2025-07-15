{ config, pkgs, lib, systemSettings, ... }:
{
    imports = [
        ../../system
        ../../system/kernel.nix
    ];

    hardware = {
        raspberry-pi."4".apply-overlays-dtmerge.enable = true;
        deviceTree = {
            enable = true;
            filter = "*rpi-4-*.dtb";
        };
    };

    boot = {
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

    console.enable = false;

    networking = {
        hostName = systemSettings.hostname;
        wireless = {
            enable = true;
            networks."${systemSettings.SSID}".psk = systemSettings.SSIDpsk;
            interfaces = [ "wlan0" ];
        };
    };

    services.sshd.enable = true;
    systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

    hardware.enableRedistributableFirmware = true;

    environment.systemPackages = with pkgs; [
        libraspberrypi
        raspberrypi-eeprom
        gcc
        cmake
        autoconf
        gdb
        ninja
        python314
        nodejs_24
        curl
        wget
        htop
        git
        nano
        micro
        vim
    ];

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 22 ];
        allowedTCPPortRanges = [
            {
                from = 3000;
                to = 3030;
            }
            {
                from = 8000;
                to = 8080;
            }
        ];
        allowedUDPPortRanges = [
            {
                from = 60000;
                to = 61000;
            }
        ];
    };

    system.stateVersion = "25.05";
}
