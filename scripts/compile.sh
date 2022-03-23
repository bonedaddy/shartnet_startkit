#! /bin/bash

CAIRO_FILE="$1"
OUTPUT="$2"

if [[ "$CAIRO_FILE" == "" ]]; then
    echo "[ERROR] invalid invocation"
    echo "[ERROR] usage: compile.sh /path/to/file/cairo <output>"
    exit 1
fi

if [[ "$OUTPUT" == "" ]]; then
    echo "$CAIRO_FILE"
    OUTPUT="$(echo $CAIRO_FILE | sed -e 's/\.cairo//g').compiled.json"
fi

cairo-compile "$CAIRO_FILE" --output "$OUTPUT"
