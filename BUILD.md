# Preparing

* Change variables at the top

Patch file was made with `diff -Naru4 VANILLA-FILE-OR-SNIPPET MANUALLY-CHANGED-FILE`

# Building

Run: `./make.sh`

# Uploading

`steamcmd +login $STEAMUSER +workshop_build_item $PWD/steamcmd.txt +quit`
