{ config, pkgs, lib, systemSettings, ... }:
{
    imports = [
        ../../system;
    ];

    hardware = {
        deviceTree = {
            enable = true;
            filter = "*rpi-zero-2-*.dtb*";
        };
        enableRedistributableFirmware = true;
    };

    boot = {
        kernelPackages = pkgs.linuxPackages;
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

    console.enable = true;

    networking = {
        hostName = systemSettings.hostname;
        wireless = {
            enable = true;
            networks."${systemSettings.SSID}".psk = systemSettings.SSIDpsk;
            interfaces = [ "wlan0" ];
        };
    };

    services = {
        sshd.enable = true;
        nginx = {
            enable = true;
            clientMaxBodySize = "4M";
            recommendedProxySettings = true;
            recommendedOptimisation = true;
            recommendedGzipSettings = true;
            virtualHosts."localhost" = {
                locations."/" = {
                    proxyPass = "http://localhost:8080/";
                };
            };
        };
    };

    systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 22 ];
    };
}
