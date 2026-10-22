# 詰まった点と原因



| 症状 | 原因 | 対処 |
|---|---|---|
| 書き込み後 `updater#` のまま | ボードのローダーの状態 | 公式の `firmware.zip` のローダー一式を書き直す |
| ZMODEM が途中で失敗 | UART の受信バッファ 256 バイトが溢れる | `UART1_RXBUFSIZE=8192` |
| `Couldn't allocate screen buffer` | 画面バッファだけが素の `malloc` で、キャッシュが解放されない | `STATIC_SCRNBUF=y` |
| 約1分後 `z_malloc: failed on allocation of 64000 bytes` | 画面切り替えの演出が、64000 バイトを2枚確保する | `NOWIPE=y` |
| Tera Term で接続すると DOOM が消える | 接続時にボードがリセットされる | 接続してから `nxdoom` を起動 |
| ③ の CI で、`refresh.sh` の差分 (2行が消える) | `UARTKBD` / `NOWIPE` が、まだ本家に無かった | ① と #3860 を当てると差分なし。③ の本文に `Depends-On: apache/nuttx-apps/pull/3869` を足した |
| ① の CI のスタイル検査が失敗 (143件、`Bad alignment`) | 現在の nxstyle は、`switch` の中の `case` を、波かっこより2文字深く書く形を求める | 字下げを直した (別コミット、字下げだけ) |
| force-push で、承認が取り消される | 新しいコミットで、以前の承認が、自動で却下される | 再承認を待つ |

注意: DOOM と NSH は、同じコンソールから入力を読むので、DOOM の実行中に打った文字は、ゲームの入力になる。
