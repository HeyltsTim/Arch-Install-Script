#!/bin/bash

mapfile -t packages < <(grep -vE '^\s*#|^\s*$'./packages.conf)

pacman -S ${packages[@]}

mapfile -t services < <(grep -vE '^\s*#|^\s*$'./services.conf)

enable_srv() {
SERVICE=${1}
dinitctl enable ${SERVICE}
dinitctl start ${SERVICE}
}

for srv in ${services[@]}
do
enable_srv ${srv}
done
