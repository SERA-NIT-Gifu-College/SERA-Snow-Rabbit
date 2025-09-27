{ self, nixpkgs, nixos-generators, nixos-hardware, ... }:
let
    inherit (self) inputs;
    mkImage = name: hardware:
        nixos-generators.nixosGenerate {
            system = "aarch64-linux";
            format = "sd-aarch64";
            modules = [
                ./${name}
                (if hardware != builtins.null then hardware else {})
                #../overlays
            ];
            specialArgs = {
                inherit inputs;
                systemSettings = import ./${name}/systemSettings.nix;
            };
        };
in
{
    sd-pi4-dev = mkImage "pi4-dev" nixos-hardware.nixosModules.raspberry-pi-4;
    sd-zero2w-dev = mkImage "zero2w-dev" builtins.null;
    sd-schraubendreher-dev = mkImage "schraubendreher-dev" builtins.null;
    sd-schraubendreher = mkImage "schraubendreher" builtins.null;
}
        
