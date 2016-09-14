#!/bin/bash
cd "$(dirname $0)"
src_dir="$PWD"
dotkeep="$HOME/.dotkeep"
linkfile () {
    src="$1"
    dotfile=".$(basename "$src")"
    dotname="$HOME/$dotfile"
    echo -n "$src --> $dotname ... " 1>&2
    if [ -f "$dotname" -a ! -h "$dotname" ]; then
      mkdir -p "$dotkeep"
      backup="$HOME/.dotkeep/$dotfile"
      echo -n "[backup $backup] " 1>&2
      rm -f "$backup"
      cp -a "$dotname" "$backup"
    fi
    ln -fs "$src" "$dotname"
    echo "done" 1>&2
}

common_dir="$src_dir/common"
machine_dir="$src_dir/machines/$(hostname -s)"
if [ ! -d "$machine_dir" ]; then
    echo "no definition for machine $(hostname -s)" 1>& 2
    exit 1
fi

for filename in "$common_dir"/* "$machine_dir"/*; do
    linkfile "$filename"
done

ln -s "$src_dir"/desks ~/.desk/desks
