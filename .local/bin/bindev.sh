#!/bin/bash

set -e

DIR_NAME="$(basename "$PWD")"
PROCFILE_DIR="$HOME/code/procfiles"

PROCFILE="$PROCFILE_DIR/Procfile.${DIR_NAME}"

if [[ ! -f "$PROCFILE" ]]; then
    PROCFILE="$PWD/Procfile.dev"
    if [[ ! -f "$PROCFILE" ]]; then
        PROCFILE="$PWD/Procfile"
        if [[ ! -f "$PROCFILE" ]]; then
            echo "Error: Procfile not found: $PROCFILE"
            exit 1
        fi
    fi
fi

echo "Using Procfile: $PROCFILE"

if pids=$(pgrep -f "foreman"); then
    echo "Another foreman instance is already running (PID(s): $pids)."
    echo "Aborting."
    exit 1
fi

if ! command -v foreman >/dev/null 2>&1; then
    echo "Installing foreman..."
    gem install foreman
fi

# Start everything except web
foreman start -f "$PROCFILE" -d "$PWD" -m all=1,web=0 <&0 &
foreman start -f "$PROCFILE" -d "$PWD" -m web=1
