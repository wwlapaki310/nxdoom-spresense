# 3本の PR の経緯

他の人のコメントは、**全文を載せず、言い換えと、元のコメントへのリンク**にしています (理由は、[docs/third-party.md](../docs/third-party.md))。

## 一覧

| 呼び名 | PR | 内容 | 結果 |
|---|---|---|---|
| ① | [nuttx-apps #3869](https://github.com/apache/nuttx-apps/pull/3869) | キーを、シリアル端末から読むオプション (`CONFIG_GAMES_NXDOOM_UARTKBD`) | 2026-10-21 マージ (anchao さん) |
| ② | [nuttx-apps #3870](https://github.com/apache/nuttx-apps/pull/3870) | 画面切り替えの演出 (ワイプ) を切るオプション | 2026-10-18 に、自分で閉じた (#3860 に、同じ機能があった) |
| ③ | [nuttx #20774](https://github.com/apache/nuttx/pull/20774) | `spresense:nxdoom` の設定とドキュメント | 2026-10-20 マージ (xiaoxiang781216 さん) |

関連する、他の人の PR: [nuttx-apps #3860](https://github.com/apache/nuttx-apps/pull/3860) (NXDoom のメモリ改善。②と同じ `NOWIPE` を含む)。

## ① nuttx-apps #3869 (キー入力)

**レビューの指摘と、対応**

| 誰が | 指摘 (言い換え) | 元のコメント | 対応 |
|---|---|---|---|
| xiaoxiang781216 | 型変換 (キャスト) を消して | [リンク](https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307787456) | 自作の時刻の関数をやめて、NXDoom に、もとからある関数を使った |
| xiaoxiang781216 | 使われていないコード (`#if 0`) を消して | [リンク](https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307787964) | 削除した |
| xiaoxiang781216 | 同じ初期化が2か所にある。まとめて | [リンク](https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307813140) | 初期化を、1か所にした |
| linguini1 | 入力デバイスごとに、ファイルを分けては (急ぎではない) | [リンク](https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307794703) | 自分の追加分は、専用のファイルに分けた |
| cederom | 書式を直して、CI を通して | [リンク](https://github.com/apache/nuttx-apps/pull/3869#pullrequestreview-5584221618) | `switch` の字下げを直した (別コミット) |
| jerpelea | コミットメッセージの `Co-Authored-By` を消して | [PR](https://github.com/apache/nuttx-apps/pull/3869) | 削除した (`Assisted-by` は残した) |

**CI の失敗と原因:** スタイル検査が、143件を指摘した。現在の nxstyle が、`switch` の中の `case` を、波かっこより2文字深く書く形を求めるため。既存のコードも含めて、字下げを直した (空白以外の変更は、なし)。

## ③ nuttx #20774 (設定とドキュメント)

| 誰が | 指摘 (言い換え) | 元のコメント | 対応 |
|---|---|---|---|
| linguini1 | `NOWIPE` の説明は、Kconfig のヘルプに任せては | [リンク](https://github.com/apache/nuttx/pull/20774#discussion_r4307798186) | ドキュメントから削除した |
| linguini1 | Squashware を、RST のリンクにして | [リンク](https://github.com/apache/nuttx/pull/20774#discussion_r4307800732) | リンクにした |
| xiaoxiang781216 | `refresh.sh` を実行して、スタイルの問題を直して | [リンク](https://github.com/apache/nuttx/pull/20774#issuecomment-6252640036) | 実行した。①と #3860 を当てると、差分なし (差分は、依存先のオプションが、まだ本家に無かったためだけ)。本文に `Depends-On:` を足した |

**依存の順番:** ③ は、① のオプションを使うので、本文に `Depends-On: apache/nuttx-apps/pull/3869` と書いた。それでも、③ が先にマージされたので、その間、本家の `spresense:nxdoom` は、キー操作ができない設定だった (① のマージで、解消)。

## ② nuttx-apps #3870 (閉じた PR)

出した翌日に、NXDoom のメンテナーが、同じ名前のオプション (`CONFIG_GAMES_NXDOOM_NOWIPE`) を含む [#3860](https://github.com/apache/nuttx-apps/pull/3860) を、出していたと分かった。Spresense で #3860 を試して、動くことを確認し、[結果を報告](https://github.com/apache/nuttx-apps/pull/3860#issuecomment-6250918633)したうえで、②を閉じた。

**学び:** 出す前に、同じ機能の PR が無いか、検索する。

## 数字

| 項目 | 値 |
|---|---|
| 出した PR | 3本 (マージ2、閉じた1) |
| 本家に入ったコミット (自分の分) | 4 (nuttx 2、nuttx-apps 2) |
| ① のコード (最終) | 新規ファイル約285行 + 既存ファイル +4 / -58 |
| ③ のコード | 設定 111行、ドキュメント +61行 |
