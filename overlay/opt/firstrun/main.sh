#!/usr/bin/env bash

find /opt/firstrun/scripts -type f -name "*.sh" | sort | xargs -I '{}' -n 1 sh -c 'test -f {}.lock || sh {} && touch {}.lock'
