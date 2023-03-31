#!/bin/bash
set -euo pipefail
#set -x

MOD_NAME="No Managers For MegaChurches"
GAME_FILES="$HOME/stellaris-game/"
# 2 = hidden, 0 = public
VISIBLE=2
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

if [ ! -e steamcmd.txt ]; then cp steamcmd-template.txt steamcmd.txt; fi
sed -i -e "s@\t\"contentfolder\"\t\t.*@\t\"contentfolder\"\t\t\"${PWD}/mod\"@" \
       -e "s@\t\"previewfile\"\t\t.*@\t\"previewfile\"\t\t\"${PWD}/mod/thumbnail.png\"@" \
       -e "s@\t\"visibility\"\t\t.*@\t\"visibility\"\t\t\"${VISIBLE}\"@" \
       -e "s@\t\"title\"\t\t.*@\t\"title\"\t\t\"${MOD_NAME}\"@" \
     steamcmd.txt
