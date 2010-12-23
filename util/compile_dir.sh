#!/bin/bash

# Compile a tree of files with recipeGrid, preserving the directory structure
# and providing several copies serving differrent numbers of people. (Quick-hack
# script.)

SOURCE="$(readlink -f "$1")"
TARGET="$(readlink -f "$2")"

cd "$SOURCE"

# Empty the target directory...
rm -rf "$TARGET"

for servings in `seq 1 10`; do
	args="-s $servings"
	subdir="/serves$servings/"
	
	find . -name "*.rec" | while read file; do
		target_file="$TARGET$subdir$file"
		mkdir -p "$(dirname "$target_file")"
		recipeGrid.py "$file" "$target_file" "$args"
	done
done
