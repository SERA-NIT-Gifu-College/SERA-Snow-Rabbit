{ self, nixpkgs, nixos-generators, ... }:
let
    inherit (self) inputs;
    mkImage = name:
        nixos-generators.nixosGenerate {
            system = "aarch64-linux";
            format = "sd-aarch64";
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
    sd-pi4-dev = mkImage "pi4-dev";
    sd-zero2w-dev = mkImage "zero2w-dev";
}
        
