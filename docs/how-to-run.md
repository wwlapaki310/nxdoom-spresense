# 構成と手順

Spresenseで、NXDoom (DOOM) を動かす手順の要約。詳しくは、本家のドキュメント (nuttx の `Documentation/platforms/arm/cxd56xx/boards/spresense/index.rst`) を参照。

- ボード: Spresense メイン基板 + 拡張ボード。ディスプレイは ILI9340 系 (320x240 横向き)。GPIO の配線は、手元で直して、表示された
- Sony のローダー (v3.4.3) が必要。書き込み後に `updater#` で止まるときは、公式の `firmware.zip` のローダーを書き直す
- 設定: `spresense:lcd` に、NXDoom 用の 19 行を足したもの
- WAD: Squashware の 1 レベル版 (672906 バイト) https://github.com/fragglet/squashware/releases 。フラッシュ (`/mnt/spif`) は 4MB なので、標準の shareware `DOOM1.WAD` (約4.2MB) は入らない
- ビルド: Docker (Ubuntu 24.04、arm-none-eabi-gcc 13.2.1)。`./tools/configure.sh spresense:nxdoom && make`
- 書き込み (Windows): `flash_writer.exe -s -c COM4 -d -b 115200 -n nuttx.spk`
- WAD の転送: NSH で `rz -p /mnt/spif` → 端末の ZMODEM で送る → `ls -l /mnt/spif` でサイズ確認
- 起動: `nxdoom -iwad /mnt/spif/doom1.wad`
- 操作: W/A/S/D・矢印で移動、J で撃つ、K で走る、L でストレイフ、E で使う、Q でメニュー
