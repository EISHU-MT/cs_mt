#!/bin/bash
gh repo clone EISHU92/cs_map
if [ -d $PWD/cs_map* ]; then
	if [ -d $PWD/csgo/mods/cs_core/cs_map ]; then
		mkdir -p $PWD/csgo/mods/cs_core/cs_map/cs_maps
		uPWD=$PWD
		cd $PWD/cs_map*
		echo "Moving `ls`"
		mv * $uPWD/csgo/mods/cs_core/cs_map/cs_maps
	fi
fi