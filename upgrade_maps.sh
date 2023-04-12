#!/bin/bash
gh repo clone EISHU92/cs_map
if [ -d $PWD/cs_map* ]; then
	if [ -d $PWD/mods/cs_core/cs_map ]; then
		mkdir -p $PWD/mods/cs_core/cs_map/cs_maps
		uPWD=$PWD
		cd $PWD/cs_map*
		echo "Moving `ls`"
		mv * $uPWD/mods/cs_core/cs_map/cs_maps
	fi
fi
