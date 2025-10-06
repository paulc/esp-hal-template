#!/bin/sh

set -o pipefail
set -o nounset
set -o errexit

TEMPLATE_DIR=$(dirname "$0")
PROJECT_DIR=${1?Usage: $0 <project_dir>}
PROJECT_NAME=$(basename "$PROJECT_DIR")

if [ -d "${PROJECT_DIR}" ]; then
    echo "ERROR: ${PROJECT_DIR} exists"
    exit 1
fi

echo "Initialising project directory: ${PROJECT_DIR}"
git init "${PROJECT_DIR}"

echo "Copying files"
for f in .cargo .gitignore Cargo.toml Makefile rust-toolchain-riscv.toml rust-toolchain-xtensa.toml src; do
    cp -R "${TEMPLATE_DIR}/${f}" "${PROJECT_DIR}"
done

sed -i "" -e "s/___name___/${PROJECT_NAME}/" "${PROJECT_DIR}/Cargo.toml"
echo "Done"
