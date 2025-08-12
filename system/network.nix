{ ... }:
{
    networking = {
        enableIPv6 = false;
        useDHCP = false;
        dhcpcd.enable = false;
        nameservers = [
            "8.8.8.8"
            "8.8.4.4"
            "1.1.1.1"
        ];
        networkmanager.enable = true;
    };
}
