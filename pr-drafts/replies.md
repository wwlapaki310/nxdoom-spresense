# レビューへの返信 (2026-10-20、最終版・コメントごと・短い版)

投稿は、ご自身で行う (私は投稿しない)。
状態: ①③ とも、署名ずみで push ずみ (①=`24a4c265`、③=`26b39ee6`)。本文も更新ずみ。

返信のしかた: 各コメントの下の「Reply」から、返信する。下のリンクで、そのコメントに飛べる (コードが変わったので「Outdated」と表示されるが、そのまま返信できる)。
投稿の順番: ① の #1〜#4 → ① のまとめ → ③ の #5、#6、#8 → ③ のまとめ。(#7 は、返信しない)
resolve を押してよいのは、#1、#2、#3、#5、#6。#4 は、linguini1 さんに任せる。

---

# ① nuttx-apps #3869

## #1 xiaoxiang781216: 「remove the cast」
https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307787456
```
Done, using the existing `i_get_time_ms()` instead.
```
> 済み。もとからある `i_get_time_ms()` を使うようにした。(自作の時刻の関数を、やめたので、型変換が不要になった)

## #2 xiaoxiang781216: 「remove the dead code」
https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307787964
```
Done, the `#if 0` block is removed.
```
> 済み。`#if 0` のブロックを削除した。

## #3 xiaoxiang781216: 「reuse the code at line 643」
https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307813140
```
Done: the duplicated `init_kbd_dev()` call is removed. The device is initialized once, in `get_kbd_event()`.
```
> 済み。重複していた `init_kbd_dev()` の呼び出しを削除した。デバイスの初期化は、`get_kbd_event()` の1か所にした。

## #4 linguini1: 「split the input options out into other C files」
https://github.com/apache/nuttx-apps/pull/3869#discussion_r4307794703
```
Tried it: the serial terminal code is now in `i_input_uartkbd.c`.
```
> やってみました。シリアル端末のコードは、`i_input_uartkbd.c` に入りました。

(もう1文を足す案: `The existing keyboard code could follow in another PR.` = 既存のキーボードのコードは、別の PR で続けられます。相手に、次の選択肢を渡せる。)

## ① まとめ (PR の下に、1つ)
```
Thanks for the review! All comments are addressed, and I tested it again on a Spresense.
```
> レビューを、ありがとうございます。すべてのコメントに対応して、Spresense で、もう一度、確認しました。

---

# ③ nuttx #20774

## #5 linguini1: 「leave this documented in the Kconfig file help text」
https://github.com/apache/nuttx/pull/20774#discussion_r4307798186
```
Done, removed.
```
> 済み。削除した。

## #6 linguini1: 「Make this an RST link」
https://github.com/apache/nuttx/pull/20774#discussion_r4307800732
```
Done, it is an RST link now.
```
> 済み。RST のリンクにした。

## #7 linguini1: 「Awesome! ...」
返信しない。

## #8 xiaoxiang781216: 「please run refresh.sh」
https://github.com/apache/nuttx/pull/20774#issuecomment-6252640036
```
Ran it: no diff with apache/nuttx-apps#3869 applied. Without it only `CONFIG_GAMES_NXDOOM_UARTKBD` is dropped, since that option comes with #3869. I added a `Depends-On:` line for the CI.
```
> 走らせました。nuttx-apps#3869 を当てると、差分なしです。当てないと、`CONFIG_GAMES_NXDOOM_UARTKBD` だけが消えます (そのオプションが #3869 に入っているため)。CI 用に、`Depends-On:` の行を足しました。

## ③ まとめ (PR の下に、1つ)
```
Thanks for the review! Updated as above.
```
> レビューを、ありがとうございます。上のとおり、更新しました。

---

## 事実との照合

| 返信の内容 | 根拠 |
|---|---|
| `i_get_time_ms()` を使う (キャストなし) | ① の差分。自作の `uartkbd_now()` を削除。`i_input_uartkbd.c` は、`i_get_time_ms()` を使う |
| `#if 0` を削除 | ① の差分。`i_input.c` から約 57 行を削除 |
| 重複した `init_kbd_dev()` を削除 | 当時のコード (`bf418f28`) の 580 行目と 643 行目が、同一の文。いまの `uartkbd_get_event()` は、初期化しない |
| `i_input_uartkbd.c` に分けた、ON のときだけビルド | ① の差分 (Makefile、CMake)。OFF のビルドで、記号が 0 個 |
| Spresense で再確認 | 2026-10-19 23:52 の実機 (エラーなし)。ディスプレイは、ご自身で確認 |
| `NOWIPE` のドキュメントを削除 | ③ の差分 (nxdoom ページ) |
| Squashware は RST リンク | ③ の差分 (Spresense ページ)。Sphinx で確認 |
| `refresh.sh` は、#3869 で差分なし。なしだと `UARTKBD` だけ消える | ご自身が手で実行して確認。`NOWIPE` は、#3860 で master に入ったので、消えない |
| `Depends-On:` の行 | #20774 の本文 5 行目 |


---

# 追加 (2026-10-20): ① の CI のスタイル検査の修正

状況: ③ は、すでにマージされた。① は、2人が承認ずみで、CI のビルドは全部成功。残る失敗は、スタイル検査 (`Check`) の 143 件だけ。
原因: 現在の nxstyle は、`switch` の中の `case` を、波かっこより2文字深く書く形を求める。
対応: 字下げだけを直した (`git diff -w` が空)。既存コードの直しは、別のコミットにした。

## ① #3869 へのコメント (PR の下に、1つ。push のあとに投稿する)

```
Fixed the failing CI style check: nxstyle `switch` indentation in `i_input.c` (separate commit, indentation only).
```
> 失敗していた CI のスタイル検査を直しました。`i_input.c` の `switch` の字下げ (nxstyle の指摘) です (別コミット、字下げだけ)。

(再レビューをお願いしたければ、末尾に `Could you take another look?` を足す。)
