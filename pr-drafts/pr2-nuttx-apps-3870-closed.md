## Summary

Add `CONFIG_GAMES_NXDOOM_NOWIPE`, an option that cuts straight to the new screen instead of melting the old one away.

DOOM melts the old screen away whenever the game state changes. That takes two more 64000 byte buffers while it runs. On a board with little RAM, such as the Spresense with 1.5 MB, the allocation fails and the game stops:

```
z_malloc: failed on allocation of 64000 bytes
```

With the option on, the wipe is skipped before its buffers are allocated. The option is off by default.

This is one of three pull requests that let NXDoom run on the Spresense: the nuttx configuration and documentation (apache/nuttx#20774) and the serial terminal keys (apache/nuttx-apps#3869). The nuttx one shows how the three fit together, so it may help to read it first. The two nuttx-apps pull requests are independent of each other and should be merged first.

## Impact

* **Users:** new option, off by default. Existing configurations are not affected.
* **Build:** none. The change is under `#ifndef CONFIG_GAMES_NXDOOM_NOWIPE`.
* **Hardware:** none.
* **Documentation:** in the nuttx pull request above.
* **Compatibility:** none.
* **Security:** none.

## Testing

**Result:** with the option on, the game no longer stops at the screen change and runs for more than two minutes.

**Host:** Windows 11, build in a Docker container (Ubuntu 24.04), `arm-none-eabi-gcc` 13.2.1.
**Board:** Spresense main board with the extension board and an ILI9340 display, `spresense:nxdoom` from the nuttx pull request, with a one-level IWAD. To try it before that is merged, use the `nxdoom-spresense` branch of https://github.com/wwlapaki310/nuttx together with the two nuttx-apps pull requests.

Before, the game stopped after about a minute:

```
z_malloc: failed on allocation of 64000 bytes

nsh>
```

After, a new game was started and played, and the game ran for more than two minutes without stopping:

```
hu_init: Setting up heads up display.
st_init: Init status bar.
```

## PR verification Self-Check

* [x] This PR introduces only one functional change.
* [x] I have updated all required description fields above.
* [x] My PR adheres to Contributing [Guidelines](https://github.com/apache/nuttx/blob/master/CONTRIBUTING.md) and [Documentation](https://nuttx.apache.org/docs/latest/contributing/index.html) (git commit title and message, coding standard, etc).
* [ ] My PR is still work in progress (not ready for review).
* [x] My PR is ready for review and can be safely merged into a codebase.
