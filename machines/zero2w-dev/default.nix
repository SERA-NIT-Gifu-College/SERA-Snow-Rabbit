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
