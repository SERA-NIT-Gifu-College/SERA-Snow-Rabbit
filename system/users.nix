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
        initialHashedPassword = "$y$j9T$Xw.k8d6X5VcDTFqztmxUm0$s2nCCGuwHN1KHjJh/HYnRNNF.d/wgBN2Y2/HWGSnIa.";
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
