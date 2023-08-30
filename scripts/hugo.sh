#!/bin/bash
WORKSPACE=$(pwd $(dirname $0)/..)
HUGO_VER="0.117.0"

echo "Workspace : ${WORKSPACE}"
echo "OS Type   : ${OSTYPE}"
echo "Hugo Ver  : ${HUGO_VER}"

if [ ! -d "${WORKSPACE}/bin" ]; then
    mkdir -p bin
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ ! -f "${WORKSPACE}/bin/hugo" ]; then
        echo "Downloading hugo_extended_${HUGO_VER}_linux-amd64.tar.gz"
        if [ ! -d "${WORKSPACE}/bin/tmp" ]; then
            mkdir -p ${WORKSPACE}/bin/tmp
        fi
        cd ${WORKSPACE}/bin/tmp
        curl -fLO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_extended_${HUGO_VER}_linux-amd64.tar.gz"
        tar xf "hugo_extended_${HUGO_VER}_linux-amd64.tar.gz" hugo
        chmod 755 hugo
        mv hugo ${WORKSPACE}/bin
        cd ${WORKSPACE}
        rm -rf ${WORKSPACE}/bin/tmp
    else
        echo "Found Hugo: ${WORKSPACE}/bin/hugo"
    fi
    HUGO_BIN="${WORKSPACE}/bin/hugo"
elif [[ "$OSTYPE" == "msys" ]]; then
    if [ ! -f "${WORKSPACE}/bin/hugo.exe" ]; then
        echo "Downloading hugo_extended_${HUGO_VER}_windows-amd64.zip"
        if [ ! -d "${WORKSPACE}/bin/tmp" ]; then
            mkdir -p ${WORKSPACE}/bin/tmp
        fi
        cd ${WORKSPACE}/bin/tmp
        curl -fLO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_extended_${HUGO_VER}_windows-amd64.zip"
        unzip "hugo_extended_${HUGO_VER}_windows-amd64.zip" hugo.exe
        chmod 755 hugo.exe
        mv hugo.exe ${WORKSPACE}/bin
        cd ${WORKSPACE}
        rm -rf ${WORKSPACE}/bin/tmp
    else
        echo "Found Hugo: ${WORKSPACE}/bin/hugo.exe"
    fi
    HUGO_BIN="${WORKSPACE}/bin/hugo.exe"
else
    echo "Error: Unknow System"
fi

if [[ "$1" == "dev" ]]; then
    ${HUGO_BIN} server --logLevel debug --disableFastRender --printUnusedTemplates --templateMetrics --noHTTPCache --bind "0.0.0.0"
else
    ${HUGO_BIN} --logLevel info --minify --templateMetrics
fi