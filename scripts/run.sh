#! /bin/bash

# for usage of --layout=small see the following
# https://github.com/starkware-libs/cairo-lang/issues/11
# https://www.cairo-lang.org/docs/how_cairo_works/builtins.html#layouts

COMPILED_CAIRO_FILE="$1"

if [[ "$COMPILED_CAIRO_FILE" == "" ]]; then
    echo "[ERROR] invalid invocation"
    echo "[ERROR] usage: run.sh /path/to/cairo_compiled.json"
    exit 1
fi

cairo-run \
    --program="$COMPILED_CAIRO_FILE" \
    --print_output \
    --print_info \
    --relocate_prints \
    --layout=small