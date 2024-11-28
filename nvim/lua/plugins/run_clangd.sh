#!/bin/bash

# TODO: test wether needs docker to run clangd
#
#

DEVCONTAINER_NAME="docker-develop:latest"

LSP_CONTAINER_NAME="lsp_clangd"

PATH_MAPPINGS="/home/prwj@fuewroclaw.com/work/hems-embedded=/home/ubuntu/hems-embedded"

docker compose -f ~/work/hems-embedded/docker/compose.yaml exec -T develop clangd --log=verbose --background-index --clang-tidy --header-insertion=iwyu --completion-style=detailed --function-arg-placeholders --fallback-style=llvm --path-mappings=${PATH_MAPPINGS}
