#!/bin/sh

LIBHELPER="$1";

# abort this script at the first nonzero return
set -o errexit

# get the directory where I live and enter that directory
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd);
cd "$DIR";

TMP_FOLDER=$(mktemp -d -t build-libhelper.XXXXXXXXXX);
cleanup_temp()
{
	# Clean up after ourselves
	rm -Rf "${TMP_FOLDER}";
}
trap cleanup_temp EXIT;

## Setup Wine environment
export WINEPREFIX="${HOME}/wine-prefix";
export WINEDLLOVERRIDES="mscoree,mshtml=";
export WINE=$(which wine);
mkdir -p "${WINEPREFIX}";

## Setup source code directory
cp -a "${DIR}/libhelper" "${TMP_FOLDER}";
SOURCE_DIR="${TMP_FOLDER}/libhelper";
cd "${SOURCE_DIR}"; \
    autoreconf --force --install; \
cd - >/dev/null;

## Build Windows packaging tools
BUILD_DIR="${TMP_FOLDER}/build";
mkdir -p "${BUILD_DIR}";
cd "${BUILD_DIR}" && "${SOURCE_DIR}/configure" --host=i686-w64-mingw32 CFLAGS="-Werror" && make;
wineserver -k || true; # make sure Wine is closed, allow this command to fail without exiting
rm -Rf "$WINEPREFIX"; # remove temporary Wine directory
export MSIDB=$(which msidb);
# Copy the helper library to the cache location
cp "${BUILD_DIR}/.libs/libhelper.dll" "${LIBHELPER}";
rm -Rf "${TMP_FOLDER}"; # remove the temporary build folders
