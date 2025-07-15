{ pkgs, config, ... }:
{
    users.users.sera = {
        isNormalUser = true;
        description = "SERA Rover Operator";
        extraGroups = [
            "networkmanager"
            "wheel"
            "input"
            "dialout"
            "video"
            "audio"
            "power"
            "plugdev"
            "gpio"
            "i2c"
            "spi"
            "netdev"
            "adm"
        ];
        initialPassword = "sera";
        createHome = true;
        home = "/home/sera";
        uid = 1000;
    };

    users.defaultUserShell = pkgs.bash;

    security.sudo = {
        enable = true;
        extraRules = [
            {
                commands = builtins.map (command: {
                    command = "/run/current-system/sw/bin/${command}";
                    options = ["NOPASSWD"];
                }) [
                    "poweroff"
                    "reboot"
                    "nixos-rebuild"
                    "nmtui"
                    "systemctl"
                ];
                groups = [ "wheel" ];
            }
        ];
    };
}
