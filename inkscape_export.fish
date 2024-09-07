#!/usr/bin/fish

for svg in (ls *.svg)
    set -l base_name (string replace '.svg' '' $svg)
    inkscape -o "$base_name".png -C -w 32 -h 32 $svg
    inkscape -o "$base_name"_hr1.png -C -w 64 -h 64 $svg
end
