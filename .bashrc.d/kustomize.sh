#!/usr/bin/env bash

if [ -x "$(command -v kustomize)" ]; then
    # shellcheck source=/dev/null
    source <(kustomize completion bash)
fi
