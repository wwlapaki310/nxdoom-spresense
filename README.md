# NXDoom on Spresense — 本家 NuttX に取り込まれるまでの記録

Sony の小さな基板 **Spresense** で、ゲームの **DOOM** (NXDoom) を動かして、**Apache NuttX** の本家に、その設定とコードを取り込んでもらうまでの記録です。作業のメモ、つまずいた点、レビューへの対応、数字を残しています。

> **English summary.** This repository records how DOOM (NXDoom) was brought up on a Sony Spresense board with an ILI9340 display, and how the changes were upstreamed to Apache NuttX (a board configuration, the documentation, and an option to read the keys from a serial terminal). It holds notes, measurements and review lessons, **not the code itself**: the code lives in the upstream commits linked below.

## 結果

Spresense (拡張ボード + ILI9340 ディスプレイ) で、DOOM が遊べます。新しいゲームの開始、移動、回転、撃つ、使う、がすべて効きます。フレームレートは、約19〜20 fps です。

デモ動画: https://youtu.be/ikh1EEGco8Q

### 本家に入ったもの (2026年10月)

| リポジトリ | コミット | 内容 | PR |
|---|---|---|---|
| apache/nuttx | [`e29a0b2262`](https://github.com/apache/nuttx/commit/e29a0b2262) | `spresense:nxdoom` の設定 | [#20774](https://github.com/apache/nuttx/pull/20774) |
| apache/nuttx | [`1f79593291`](https://github.com/apache/nuttx/commit/1f79593291) | NXDoom のドキュメント | [#20774](https://github.com/apache/nuttx/pull/20774) |
| apache/nuttx-apps | [`2d68f38f`](https://github.com/apache/nuttx-apps/commit/2d68f38f) | キーを、シリアル端末から読むオプション | [#3869](https://github.com/apache/nuttx-apps/pull/3869) |
| apache/nuttx-apps | [`ff3ebcd6`](https://github.com/apache/nuttx-apps/commit/ff3ebcd6) | スタイル (nxstyle) の修正 | [#3869](https://github.com/apache/nuttx-apps/pull/3869) |

最初は、3本の PR を出しました。そのうち「画面切り替えの演出 (ワイプ) を切るオプション」([#3870](https://github.com/apache/nuttx-apps/pull/3870)) は、1日違いで、NXDoom のメンテナーが出していた [#3860](https://github.com/apache/nuttx-apps/pull/3860) に、同じ機能が入っていたので、自分で閉じました (#3860 の動作は、Spresense でも確認して、報告しました)。

## 読む順番

| ファイル | 内容 |
|---|---|
| [docs/timeline.md](docs/timeline.md) | 10/14〜21 の時系列 |
| [docs/how-to-run.md](docs/how-to-run.md) | 構成と手順の要約 |
| [docs/troubleshooting.md](docs/troubleshooting.md) | 詰まった点と原因 |
| [docs/measurements.md](docs/measurements.md) | 実機の確認結果、フレームレート |
| [docs/lessons.md](docs/lessons.md) | 本家に貢献するときの、規約と学び |
| [archive/prs.md](archive/prs.md) | 3本の PR の経緯と、レビューの指摘 (要約とリンク) |
| [pr-drafts/](pr-drafts/) | 出した PR の本文、返信、解説 |
| [tools/](tools/) | 確認に使ったスクリプト |

## ライセンスと、含まないもの

- **このリポジトリの、自作の文書とスクリプトは、Apache-2.0** です ([LICENSE](LICENSE))。NuttX の本体と同じです。
- **NXDoom のコードは、GPLv2** です (Chocolate DOOM から派生したもので、NuttX の他の部分とは、ライセンスが違います)。**コードは、このリポジトリに含めていません。** 上の本家のコミットを、参照してください。
- Sony の書き込みツール (`flash_writer`)、ローダー (`firmware.zip`)、WAD ファイル、ファームウェア (`.spk`)、他の人のレビューコメントの全文、CI のログは、**含めていません**。詳しくは、[docs/third-party.md](docs/third-party.md) を参照してください。

## AI の支援について

この作業は、AI (Claude) の支援を受けて進めました。コードと文書の一部を、AI が書き、人が確認しました。本家のコミットには、NuttX の規約に従って、`Assisted-by:` で明記してあります。署名 (`Signed-off-by`) は、人 (著者) が付けています。

## 連絡

[Issue #1](https://github.com/wwlapaki310/nxdoom-spresense/issues/1) に、作業中のメモがあります。
