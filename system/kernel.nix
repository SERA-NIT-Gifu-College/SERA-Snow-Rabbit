{ pkgs, ... }:
let
    version = "6.12.34";
    branch = "6.12";
    kernelSource = "https://github.com/raspberrypi/linux/archive/refs/tags/stable_20250702.tar.gz";
    kernelSourceHash = "";
in
{
    boot.kernelPackages = let
        linux_rpi_pkg = { fetchurl, buildLinux, ... } @ args:
            buildLinux (args // {
                version = version;
                modDirVersion = version;

                src = fetchurl {
                    url = kernelSource;
                    hash = kernelSourceHash;
                };
                kernelPatches = [];

                extraConfig = "";
            } // (args.argsOverride or {})
        );
        linux_rpi = pkgs.callPackage linux_rpi_pkg {};
    in
        pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_rpi);
}
