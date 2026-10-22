# SPDX-License-Identifier: Apache-2.0
#
# Start NXDoom on a Spresense over the serial console and send a fixed set of keys,
# so that the same check can be repeated after every firmware change.
#
# What it does:
#   1. open the COM port (this resets the board on some PCs), wait for NSH
#   2. run:  nxdoom -iwad /mnt/spif/doom1.wad
#   3. wait for the demo, then send: q, Enter x3 (new game), then hold w / a / d / j,
#      tap e, hold s
#   4. leave the game running and count error words in the board output
#
# The result on the display has to be checked by eye: the script only prints the
# times of the keys it sends.
#
# usage: .\serial-play-test.ps1 [-Port COM4] [-Wad /mnt/spif/doom1.wad]
# Close every other program that holds the port (for example a terminal) first.

param(
    [string]$Port = "COM4",
    [string]$Wad = "/mnt/spif/doom1.wad"
)

function T($m) { "{0:HH:mm:ss} {1}" -f (Get-Date), $m }

$p = New-Object System.IO.Ports.SerialPort $Port, 115200, None, 8, one
$p.ReadTimeout = 500
$opened = $false
for ($i = 0; $i -lt 8 -and -not $opened; $i++) {
    try { $p.Open(); $opened = $true } catch { Start-Sleep 2 }
}
if (-not $opened) { "Cannot open $Port. Is another program using it?"; return }

$null = $p.ReadExisting()
$p.Write("`r`n"); Start-Sleep 1; $null = $p.ReadExisting()
T "start nxdoom"
$p.Write("nxdoom -iwad $Wad`r`n")
Start-Sleep 40
T "the title / demo should be playing"

function Tap($key, $msg) { T $msg; $p.Write($key); Start-Sleep 3 }
function Hold($key, $msg, $sec) {
    T "$msg (${sec}s)"
    $end = (Get-Date).AddSeconds($sec)
    while ((Get-Date) -lt $end) { $p.Write($key); Start-Sleep -Milliseconds 120 }
    Start-Sleep 2.5
}

Tap "q"   "q: open the menu"
Tap "`r"  "Enter: New Game"
Tap "`r"  "Enter: next menu"
Tap "`r"  "Enter: skill level -> the game starts"
Start-Sleep 5
Hold "w" "w: forward" 3
Hold "a" "a: turn left" 2
Hold "d" "d: turn right" 2
Hold "j" "j: fire" 2
Tap  "e" "e: use"
Hold "s" "s: backward" 2
T "done; leaving the game running for 45 s"
Start-Sleep 45

$tail = $p.ReadExisting()
$errors = [regex]::Matches($tail, "z_malloc|failed|ERROR|assert|PANIC", "IgnoreCase").Count
"error words in the board output: $errors"
$p.Close()
