# SERA Snow Rabbit

NixOS configs for SERA's rovers.

## Build SD Image

With Nix installed and flake enabled:

```bash
$ nix build '.#<target>'
```

`<target>` is listed in `machines/sdImages.nix`.

