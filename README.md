![All icons in this repository](all_icons.png)

# Role-colored Glowing Job Icons

A mod for Final Fantasy XIV. Exchanges the glowing job icons (used in the journal for job quests) with variants that are colored based on the role of that job. Intended to be used with the Party Icons plugin, but can of course also be used on its own. Role colors are taken from the Party Icons plugin. Original SVGs for the job icons from https://github.com/xivapi/classjob-icons.

## Building

The build script in this repo is really only for myself (and written for the fish shell), but if you also want to use it, it should mostly be self-explanatory. Requires Inkscape to convert SVGs to PNGs, and TexTools to convert those to TEX files. `CONSOLE_TOOLS_CMD` should contain a command that launches TexTools' `ConsoleTools.exe`.

Make sure you only run `build.fish` from the repository root.

## Installing

You can grab the packaged mod from Heliosphere: https://heliosphere.app/mod/m76rkjzme56bz1v121ajp9wmwm
