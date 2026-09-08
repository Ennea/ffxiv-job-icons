#!/usr/bin/fish

if not set -q TEXCONV_CMD
    echo "Environment variable TEXCONV_CMD must be set"
    exit
end

if not set -q FFXIV_TEX_CONVERTER_PATH
    echo "Environment variable FFXIV_TEX_CONVERTER_PATH must be set"
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

# convert PNGs to DDS using texconv
set -l texconv_cmd (string split ' ' $TEXCONV_CMD)
echo -n 'Converting to DDS '
for file in (ls *.png)
    echo -n .
    set -l out_name (string replace '.png' '' $file).tex
    WINEDEBUG=-all $texconv_cmd -f BGRA $file > /dev/null 2>&1
end
echo

echo 'Removing PNGs'
rm *.png
cd ..

# convert DDS to TEX using kartoffel's ffxiv-tex-converter
echo -n 'Converting to TEX'
source $FFXIV_TEX_CONVERTER_PATH/.venv/bin/activate.fish
python $FFXIV_TEX_CONVERTER_PATH/ffxiv_tex_converter.py -c dds-to-tex -d build

# create the PMP file
echo 'Making PMP'
cd build_tex
cp -r ../mod_template/* .
mv *.tex ui/icon/062000
zip -r role-colored-glowing-job-icons.pmp * > /dev/null
