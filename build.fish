#!/usr/bin/fish

if not set -q CONSOLE_TOOLS_CMD
    echo "Environment variable CONSOLE_TOOLS_CMD must be set"
    exit
end


# clean old build first
git clean -Xdf

# create build directory and cd into it
if not test -d build
    mkdir build
end
cd build

# convert SVGs to PNG using inkscape
echo -n 'Making PNGs '
for file in (find ../isvg/ -type f -regex '.*?/062.*svg')
    echo -n .
    set -l base_name (string replace '.svg' '' (string split '/' $file)[-1])
    inkscape -o "$base_name".png -C -w 32 -h 32 $file
    inkscape -o "$base_name"_hr1.png -C -w 64 -h 64 $file
end
echo

# convert PNGs to TEX using TexTools' ConsoleTools
set -l cmd (string split ' ' $CONSOLE_TOOLS_CMD)
echo -n 'Making TEXs '
for file in (ls *.png)
    echo -n .
    set -l out_name (string replace '.png' '' $file).tex
    WINEDEBUG=-all $cmd '/wrap' $file $out_name ui/icon/062000/$out_name > /dev/null
end
echo

echo 'Removing PNGs'
rm *.png

# create the PMP file
echo 'Making PMP'
cp -r ../mod_template/* .
mv *.tex ui/icon/062000
zip -r role-colored-glowing-job-icons.pmp * > /dev/null
