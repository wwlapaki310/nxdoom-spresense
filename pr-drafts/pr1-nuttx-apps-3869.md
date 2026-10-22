## Summary

Add `CONFIG_GAMES_NXDOOM_UARTKBD`, an option that lets NXDoom read its keys from a serial terminal.

NXDoom reads its keys only from a keyboard character driver, so a board without one cannot play it. Some boards, such as the Spresense, have only a serial console. With the option on, NXDoom reads bytes from the tty named by `CONFIG_GAMES_NXDOOM_KBDPATH` (for example `/dev/console`) and turns them into the same keyboard events that the driver path produces:

* W, A, S, D and the arrow keys move, J fires, K runs, L strafes, E or space uses, and Q or Esc opens the menu.
* A terminal reports a key press but never its release, so each key is released again 250 ms after its last byte.

The option is off by default. The code is in its own file, `i_input_uartkbd.c`, which is built only when the option is on, so `i_input.c` has just one call to it; the dead `#if 0` block in `i_input.c` is removed. The key handling follows `translate_speckey()` in the same file, and the arrow keys are the usual VT100/xterm sequences. No code was copied from another project. Keeping this in the application was the simplest way; a reusable keyboard driver fed from a tty would be another option, and I can move it there if you prefer.

This is one of three pull requests that let NXDoom run on the Spresense: the nuttx configuration and documentation (apache/nuttx#20774) and the memory improvements, which include the option to disable the screen wipe (apache/nuttx-apps#3860, by another author, already merged). The nuttx one shows how they fit together, so it may help to read it first. This pull request is rebased onto #3860 and should be merged before the nuttx one.

## Impact

* **Users:** new option, off by default. Existing configurations are not affected.
* **Build:** none. The code is under `#ifdef CONFIG_GAMES_NXDOOM_UARTKBD`.
* **Hardware:** none.
* **Documentation:** in the nuttx pull request above.
* **Compatibility:** none.
* **Security:** none.

## Testing

**Result:** the game starts on a Spresense and is controlled with keys sent over the serial console. Demo video: https://youtu.be/ikh1EEGco8Q

**Host:** Windows 11, build in a Docker container (Ubuntu 24.04), `arm-none-eabi-gcc` 13.2.1.
**Board:** Spresense main board with the extension board and an ILI9340 display, `spresense:nxdoom` from the nuttx pull request. To try it before that is merged, use the `nxdoom-spresense` branch of https://github.com/wwlapaki310/nuttx together with this pull request.

With a one-level IWAD in the flash, the game started and keys sent over the console worked: `q` opened the menu, Enter started a new game, `w` and `s` moved, `a` and `d` turned, `j` fired and `e` used. This was checked on the display.

```
nsh> nxdoom -iwad /mnt/spif/doom1.wad
                             NXDoom v0.0.0
...
hu_init: Setting up heads up display.
st_init: Init status bar.
```

## PR verification Self-Check

* [x] This PR introduces only one functional change.
* [x] I have updated all required description fields above.
* [x] My PR adheres to Contributing [Guidelines](https://github.com/apache/nuttx/blob/master/CONTRIBUTING.md) and [Documentation](https://nuttx.apache.org/docs/latest/contributing/index.html) (git commit title and message, coding standard, etc).
* [ ] My PR is still work in progress (not ready for review).
* [x] My PR is ready for review and can be safely merged into a codebase.



