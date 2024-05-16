#!/usr/bin/env bash

if [ -x "$(command -v yq)" ]; then
    # shellcheck source=/dev/null
    source <(yq shell-completion bash)
fi
