# SERA ユキウサギ

SERAローバー用NixOS設定ファイル

## SDイメージファイルのビルド

Nixをインストールしてflakesを有効化しておく。

```bash
$ nix build '.#<target>'
```

`<target>`には`machines/sdImage.nix`内で定義されている名前を入れる。

## `systemSettings.nix`

各システムに`machines/<システム名>/`に`systemSettings.nix`を配置し、以下の3つの値を定義する必要がある：

* SSID: ネットワークのSSID、空の文字列で定義するとNetworkManagerが代わりに使用される
* SSIDpsk: ネットワークのパスワード、SSIDが空の場合パスワードも空にしてもよい
* locale: システムのローケル文字列 (例： ja_JP.UTF-8)

幾つかのシステムには追加で必要な値を定義する場合がある。それらの値はシステムの`default.nix`のコメントを必要に応じて参照する。

***機密情報が含まれている場合があるので`systemSettings.nix`をGitに追加しないこと。***

