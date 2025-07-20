# SERA ユキウサギ

SERAローバー用NixOS設定ファイル

## SDイメージファイルのビルド

Nixがインストールしてflakesを有効化しておく。

```bash
$ nix build '.#<target>'
```

`<target>`には`machines/sdImage.nix`内で定義されている名前を入れる。

