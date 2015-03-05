#!/usr/bin/env bash

set -e
set -u

filename() {
  echo "$1" | rev | cut -d "." -f 2- | rev
}

cd "gnome-flat/scalable"
for type in *; do
  echo "---> Scaling type $type"
  for size in "8" "16" "22" "24" "32" "48" "256"; do
    echo "  -> size: $size"
    echo -n "     "
    target="../${size}x${size}"
    mkdir -p "$target/$type"
    for file in "$type"/*; do
      scaled="$target/$(filename "$file").png"
      if ! test -e "$scaled"; then
        (inkscape -e "$scaled" -w "$size" -h "$size" -y 0 "$file" > /dev/null && convert -strip "$scaled" "$scaled") &
      fi
      echo -n "."
    done
    echo " "
  done
done