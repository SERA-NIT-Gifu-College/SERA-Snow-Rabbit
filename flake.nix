{
    description = "NixOS Configs for SERA's Rovers";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, nixos-generators, ... }:
        let
            pkgs = import inputs.nixpkgs {
                system = "aarch64-linux";
                hostPlatform = "x86_64-linux";
            };

            lib = inputs.nixpkgs.lib;
        in
        {
#            nixosConfigurations = import ./machines/nixosConfig.nix inputs;
#            packages.aarch64-linux = import ./machines/sdImage.nix inputs;
            nixosModules = {
                system = {
                    disabledModules = [ "profiles/base.nix" ];
                    system.stateVersion = "25.05";
                };
                users = {
                    users.users = {
                        test = {
                            password = "test";
                            isNormalUser = true;
                            extraGroups = [ "wheel" ];
                        };
                    };
                };
            };

            packages.aarch64-linux = {
                sdcard = nixos-generators.nixosGenerate {
                    system = "aarch64-linux";
                    format = "sd-aarch64";
                    modules = with self.nixosModules; [ system users ];
                };
            };
        };
}
