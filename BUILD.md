# Preparing

* Change variables at the top

Patch file was made with `diff -Naru4 VANILLA-FILE-OR-SNIPPET MANUALLY-CHANGED-FILE`

The vanilla snippet can be generated with:

```sh
< "$HOME/stellaris-game/common/buildings/08_unity_buildings.txt" perl -ane '
if (/^(building_temple|building_holotemple|building_sacred_nexus|building_sacrificial_temple_1|building_sacrificial_temple_2|building_sacrificial_temple_3|building_league_offices)/ ... /^\}/) {
  print;
}
' > tmp/vanilla-snippet.txt
```

# Building

Run: `./make.sh`

# Uploading

`steamcmd +login $STEAMUSER +workshop_build_item $PWD/steamcmd.txt +quit`
