# tools

確認に使ったスクリプトです。どれも、自作で、Apache-2.0 です ([LICENSE](../LICENSE))。

| ファイル | 用途 |
|---|---|
| `check-refresh.sh` | NuttX の CI が行う、defconfig の整形の検査 (`tools/refresh.sh`) を、手元で実行する。Linux 環境の中で動く |
| `check-refresh.ps1` | 上を、Windows から、Docker のコンテナに渡して実行する起動用 |
| `serial-play-test.ps1` | シリアルコンソールから、`nxdoom` を起動して、決まったキーを送る。実機で、同じ確認を、何度も繰り返すため |

## 注意

- コンテナ名 (`doom-build`) や、作業フォルダ (`/work/nuttx`) は、例です。環境に合わせて、引数で変えてください。
- `serial-play-test.ps1` は、COM ポートを占有します。端末ソフトなど、ほかのプログラムは、先に閉じてください。結果は、**ディスプレイを、目で見て**確認します。
- フレームレートは、ゲームの描画の回数を、一時的に数えるコードを入れて、測りました。そのコードは、GPL の NXDoom のファイルへの差分なので、**ここには、置いていません。** 方法は、[../docs/measurements.md](../docs/measurements.md) を参照してください。
