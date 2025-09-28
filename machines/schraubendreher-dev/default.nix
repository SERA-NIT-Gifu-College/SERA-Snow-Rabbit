{ config, pkgs, lib, systemSettings, ... }:
{
    imports = [
        ../../system
        ./devPackages.nix
    ];

    hardware = {
        deviceTree = {
            enable = true;
            filter = "*rpi-zero-2-*.dtb";
        };
        enableRedistributableFirmware = true;
        bluetooth = {
            enable = false;
            powerOnBoot = false;
        };
    };

    boot = {
        kernelPackages = pkgs.linuxPackages;
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

    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
    }];

    console.enable = true;

    networking = {
        hostName = "schraubendreher-dev";
        wireless = {
            enable = builtins.stringLength systemSettings.SSID != 0;
            networks."${systemSettings.SSID}".psk = systemSettings.SSIDpsk;
            interfaces = [ "wlan0" ];
        };
        networkmanager.enable = builtins.stringLength systemSettings.SSID == 0;
    };

    services.sshd.enable = true;
    systemd.services.sshd.wantedBy = lib.mkOverride 40 ["multi-user.target" ];

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
