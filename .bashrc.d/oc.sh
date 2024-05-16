#!/usr/bin/env bash

if [ -x "$(command -v oc)" ]; then
    # shellcheck source=/dev/null
    source <(oc completion bash)
fi

