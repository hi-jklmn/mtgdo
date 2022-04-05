#!/bin/bash

# Usage:
#   depscheck.sh [programs...]

MISSING=""

# Dependency checker
for dep in "$@"; do
    command -v $dep >/dev/null 2>&1 || MISSING="$MISSING$dep "
done

if ! [ -z "$MISSING" ]; then
    echo "[$0]: Missing program: $MISSING"; exit 1
fi


