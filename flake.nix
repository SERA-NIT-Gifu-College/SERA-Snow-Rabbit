{
    description = "NixOS Configs for SERA's Rovers";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = inputs@{ self, nixpkgs, nixos-generators, nixos-hardware, flake-utils, ... }:
        inputs.flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import inputs.nixpkgs {
                    localSystem = system;
                    crossSystem = "aarch64-linux";
                };

                lib = inputs.nixpkgs.lib;
            in
            {
                nixosConfigurations = import ./machines/nixosConfig.nix inputs;
                packages = import ./machines/sdImage.nix inputs;
            }
        );
}
