{
    description = "NixOS Configs for SERA's Rovers";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    };

    outputs = inputs@{ self, nixpkgs, ... }:
        let
            pkgs = import inputs.nixpkgs {};

            lib = inputs.nixpkgs.lib;
        in
        {
            nixosConfigurations = import ./machines inputs;
        }
}
