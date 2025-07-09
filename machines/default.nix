{ ... }:
{
    nixosConfig = import ./nixosConfig.nix;
    sdImage = import ./sdImage.nix;
}
