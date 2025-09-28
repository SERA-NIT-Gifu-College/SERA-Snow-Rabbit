# SERA Snow Rabbit

NixOS configs for SERA's rovers.

## Build SD Image

With Nix installed and flake enabled:

```bash
$ nix build '.#<target>'
```

`<target>` is listed in `machines/sdImages.nix`.

## `systemSettings.nix`

Each system requires to have `systemSettings.nix` under `machines/<system name>/`. In this nix file, you need to define at least three values:

* SSID: SSID of network, leave blank (pass in empty string) to use NetworkManager instead.
* SSIDpsk: Password to network, leave blank if SSID is empty
* locale: system locale string (ex. en_US.UTF-8)

Some system requires other values, refer to head comment of system's `default.nix` as needed.

***Do not add `systemSettings.nix` to Git as it may contains sensitive information.***

