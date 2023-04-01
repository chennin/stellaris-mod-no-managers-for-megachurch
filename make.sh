#!/bin/bash
# Copyright 2023 Chris Henning
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
set -euo pipefail
#set -x

MOD_NAME="Temple Manager Repellent"
GAME_FILES="$HOME/stellaris-game/"
# 3 = unlisted, 2 = hidden, 1 = friends, 0 = public
VISIBLE=3
# Vanilla source, not the full path
SRCFILE="common/buildings/08_unity_buildings.txt"



lc_mod_name=$(echo $MOD_NAME | tr ' ' '-')
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
       -e "s@\t\"description\"\t\t\"New description.\"@@" \
     steamcmd.txt
