#!/usr/bin/env bash

if [ -x "$(command -v dircolors)" ]; then
    if test -r "${HOME}/.dircolors" ; then
        eval "$(dircolors -b "${HOME}/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

