## Summary

Add a configuration that plays NXDoom on a Spresense with an ILI9340 display attached to the extension board, and document it.

Depends-On: apache/nuttx-apps/pull/3869

**Please merge apache/nuttx-apps#3869 first.** This configuration uses the option it adds (`CONFIG_GAMES_NXDOOM_UARTKBD`); without it the option is silently ignored and the game cannot be controlled.

Getting NXDoom to run on the Spresense took three steps:

1. **Run on the board** (this pull request). The display is used as a frame buffer through `CONFIG_LCD_FRAMEBUFFER` at 320x240 in landscape; `up_fbinitialize()` already calls `board_lcd_initialize()`, so no driver code is needed. The WAD file is kept in the on-board SPI flash (`/mnt/spif`) and sent over the console with `rz`.
2. **Make it playable.** The Spresense has no keyboard, so the keys are read from the serial console (`CONFIG_GAMES_NXDOOM_UARTKBD`, added to nuttx-apps by a separate pull request).
3. **Keep it from stopping.** With 1.5 MB of RAM the game stopped after about a minute, when the screen wipe asked for two more 64000 byte buffers. The wipe can now be disabled (`CONFIG_GAMES_NXDOOM_NOWIPE`, added by the memory improvements in apache/nuttx-apps#3860, a separate pull request by another author that is already merged).

Other boards that play NXDoom, for example `linum-stm32h753bi`, have a keyboard driver and enough RAM, so they did not need steps 2 and 3.

The configuration is `spresense:lcd` plus the NXDoom settings, with the screen wipe disabled, the render buffer in `.bss`, and `rz` enabled. The console UART receive buffer is raised from 256 bytes to 8 KB, because the default overruns while `rz` writes to the flash. The `rz` error limit, buffer sizes and connect time were raised together with it when the transfer failed; I did not test which of these changes are strictly needed.

Documentation is in two commits: the serial terminal keys option on the NXDoom page, and the procedure (getting a WAD, sending it, starting the game) on the Spresense page.

Related nuttx-apps pull requests: serial terminal keys (apache/nuttx-apps#3869, not merged yet) and the memory improvements with the screen wipe option (apache/nuttx-apps#3860, merged). Reviews of the configuration and the documentation are welcome while #3869 waits to be merged.

## Impact

* **Users:** new configuration only. No existing configuration is changed.
* **Build:** none outside the new configuration.
* **Hardware:** Spresense only. No driver or board code changes.
* **Documentation:** the Spresense page gains an `nxdoom` section; the NXDoom page describes the new serial terminal keys option.
* **Compatibility:** none.
* **Security:** none.

## Testing

**Result:** the game starts on a Spresense, is shown on the display and is played with keys sent over the serial console, at about 19 to 20 frames per second. Demo video: https://youtu.be/ikh1EEGco8Q

**Host:** Windows 11, build in a Docker container (Ubuntu 24.04), `arm-none-eabi-gcc` 13.2.1, on the current nuttx and nuttx-apps master (which includes apache/nuttx-apps#3860) with apache/nuttx-apps#3869 applied.
**Board:** Spresense main board with the extension board and an ILI9340 display, with the Sony loader v3.4.3 installed.

Built from scratch with `./tools/configure.sh spresense:nxdoom && make`, flashed with `flash_writer`, and the one-level Squashware IWAD (672906 bytes) sent with `rz -p /mnt/spif`:

```
nsh> ls -l /mnt/spif
/mnt/spif:
 -rw-r--r--      672906 doom1.wad
nsh> nxdoom -iwad /mnt/spif/doom1.wad
                             NXDoom v0.0.0
...
hu_init: Setting up heads up display.
st_init: Init status bar.
```

The game is shown on the display. From keys sent over the console, a new game was started, and the player could move, turn, fire and use. The frame rate was about 19 to 20 frames per second while playing, measured with a temporary counter. The documentation was built with Sphinx and the new sections render.

The flash area that holds the WAD is 4 MB, so the shareware `DOOM1.WAD` (about 4.2 MB) does not fit in it; only the one-level Squashware IWAD was tried.

## PR verification Self-Check

* [x] This PR introduces only one functional change.
* [x] I have updated all required description fields above.
* [x] My PR adheres to Contributing [Guidelines](https://github.com/apache/nuttx/blob/master/CONTRIBUTING.md) and [Documentation](https://nuttx.apache.org/docs/latest/contributing/index.html) (git commit title and message, coding standard, etc).
* [ ] My PR is still work in progress (not ready for review).
* [x] My PR is ready for review and can be safely merged into a codebase.



