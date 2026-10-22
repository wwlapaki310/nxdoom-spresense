#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
#
# Check that a NuttX board defconfig is already normalized, the way the NuttX CI
# does with tools/refresh.sh.  Run it inside a Linux environment that has a
# nuttx tree and a nuttx-apps tree next to each other (nuttx/ and apps/).
#
# usage: check-refresh.sh [<nuttx dir> [<board>/<config>]]
#   default: /work/nuttx  spresense/nxdoom
#
# Result:
#   "NO DIFFERENCE"    the defconfig is already normalized
#   "DIFFERENCE FOUND" refresh.sh changed it (for example, it drops an option
#                      that does not exist in the apps tree yet)

NUTTX_DIR=${1:-/work/nuttx}
CONFIG=${2:-spresense/nxdoom}

cd "$NUTTX_DIR" || exit 1
D=$(ls boards/*/*/${CONFIG%%/*}/configs/${CONFIG#*/}/defconfig 2>/dev/null | head -1)
[ -n "$D" ] || { echo "defconfig for $CONFIG not found under boards/"; exit 1; }

cp "$D" /tmp/defconfig.before
echo "--- tools/refresh.sh --silent $CONFIG"
./tools/refresh.sh --silent "$CONFIG" 2>&1 | tail -6
echo "--- diff (before vs after refresh)"
if diff /tmp/defconfig.before "$D"; then
  echo "NO DIFFERENCE (the defconfig is already normalized)"
else
  echo "DIFFERENCE FOUND (see the diff above)"
  # refresh.sh rewrites the file in place; put it back so the tree stays as it was
  cp /tmp/defconfig.before "$D"
fi
