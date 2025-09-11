{ self, nixpkgs, ... }:
let
    inherit (self) inputs;
    mkMachine = name:
        nixpkgs.lib.nixosSystem {
            modules = [
                ./${name}
                ../overlays
            ];

            specialArgs = {
                inherit inputs;
                systemSettings = import ./${name}/systemSettings.nix;
            };
        };
in
{
    pi4-dev = mkHost "pi4-dev";
    zero2w-dev = mkHost "zero2w-dev";
    schraubendreher-dev = mkHost "schraubendreher-dev";
}
