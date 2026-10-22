# 規約と学び

NuttX に貢献するときに、つまずいた点と、わかったこと。

- 件名は `機能領域: 説明.` (末尾にピリオド)。`Assisted-by: Claude:claude-sonnet-5-5` が必須。**AI は `Signed-off-by` を付けてはいけない** (人間が `git commit -s` で付ける)
- PR は、機能ごとに分ける。nuttx-apps の変更のドキュメントは、nuttx の別 PR に入れる。スタイルの直しは、別コミットにする
- **出す前に、同じ機能の PR が無いか、必ず検索する** (②が #3860 と重複していた)
- **別の PR に依存する PR は、本文に `Depends-On: owner/repo/pull/N` と書く** (NuttX の CI が、そのPR を当ててビルドする)。依存先がマージされる前に、先にマージされる可能性がある
- **`refresh.sh --silent <board>/<config>`** で、defconfig の整形を、手元で確認できる (Linux 環境が要る)
- **変更するファイルの、スタイルの指摘は、自分が原因でなくても直す** (`CONTRIBUTING.md` 2.1)。検査ツール (nxstyle) は、時々、厳しくなる
- **NuttX のコミットでは、`Assisted-by:` だけを書く。`Co-Authored-By: Claude ...` は付けない** (jerpelea さんの依頼)。付けると、直すために、force-push が要り、承認が取り消される
- `checkpatch.sh -m -g --stdin` で、コミットメッセージを検査できる。署名が付いた状態で、全項目が通る
- AI を使ったコードを直したら、署名は外して、人間が付け直す
- レビューの返信は、短く。直したものは「Done, …」の1文でよい
