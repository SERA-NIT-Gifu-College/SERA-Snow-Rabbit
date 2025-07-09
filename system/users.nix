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
        initialHashedPassword = "$y$j9T$2y7ILsWF9xVSfVg0CUp671$vrJB8OtjdjIcrJdJkU3hBMYRmuZSg3v7vlc9hITTRD6";
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
