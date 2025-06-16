{ systemSettings, ... }:
{
    time.timeZone = "Etc/UTC";

    services.timesyncd = {
        enable = true;
        servers = null;
        fallbackServers = [
            "time1.google.com"
            "time2.google.com"
            "time3.google.com"
            "time4.google.com"
        ];
    };
}
