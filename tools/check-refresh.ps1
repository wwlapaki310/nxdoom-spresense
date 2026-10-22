# SPDX-License-Identifier: Apache-2.0
#
# Windows launcher for check-refresh.sh: copy it into a running Docker container
# that has the nuttx and apps trees, and run it there.
#
# usage: .\check-refresh.ps1 [-Container doom-build] [-NuttxDir /work/nuttx] [-Config spresense/nxdoom]

param(
    [string]$Container = "doom-build",
    [string]$NuttxDir = "/work/nuttx",
    [string]$Config = "spresense/nxdoom"
)

docker start $Container | Out-Null
docker cp "$PSScriptRoot\check-refresh.sh" "${Container}:/tmp/check-refresh.sh"
# the file may have Windows line endings; strip them inside the container
docker exec $Container bash -c "tr -d '\r' < /tmp/check-refresh.sh > /tmp/check-refresh.lf.sh"
docker exec $Container bash /tmp/check-refresh.lf.sh $NuttxDir $Config
