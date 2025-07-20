{ config, pkgs, ... }:
{
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
}
