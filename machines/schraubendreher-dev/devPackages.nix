{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        libraspberrypi
        raspberrypi-eeprom
        gcc
        cmake
        pkg-config
        autoconf
	libgpiod
        gdb
        ninja
        curl
        wget
        htop
        tmux
        git
        gh
        nano
        micro
        vim
    ];
}
