{ ... }:
{
    nix = {
        gc.automatic = false;

        settings = {
            auto-optimise-store = true;
            allowed-users = ["@wheel"];
            trusted-users = ["@wheel"];
            commit-lockfile-summary = "Updated flake.lock";
            accept-flake-config = true;
            keep-derivations = true;
            keep-outputs = true;
            warn-dirty = false;
            sandbox = true;
            max-jobs = "auto";
            log-lines = 50;
            experimental-features = [ "nix-command" "flakes" ];
        };
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            allowBroken = false;
        };
    };
}
