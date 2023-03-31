#!/bin/bash
set -euo pipefail
#set -x

MOD_NAME="No Managers For Megachurches"
GAME_FILES="$HOME/stellaris-game/"
lc_mod_name=$(echo $MOD_NAME | tr ' ' '-')

SRCFILE="common/buildings/08_unity_buildings.txt"
DESTNAME="${lc_mod_name}.txt"
DEST="mod/$(dirname "${SRCFILE}")/${DESTNAME}"

mkdir -p $(dirname "${DEST}")
echo -e -n "# ${MOD_NAME}\r\n" > "${DEST}"
< "${GAME_FILES}/${SRCFILE}" perl -ane '
while (<STDIN>) {
  if (/^(building_temple|building_holotemple|building_sacred_nexus|building_sacrificial_temple_)/ ... /^}/) {
    print;
  }
}
' >> "${DEST}"
patch ${DEST} buildings.patch
unix2dos -q "${DEST}"
