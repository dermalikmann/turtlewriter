#!/usr/bin/env bash

find /etc/init.d/firstrun/ -type f -name "*.sh" -exec '[[ ! -f {}.lock ]] && sh {} && touch {}.lock'
