#!/bin/bash
####
# get package paths in given p
####
set -e

DIR=$1

function f_get_pkg_name() {
    path=$1
    IFS='/' read -ra sub_paths <<< $path
    echo "${sub_paths[-1]}"
}

toUpdatePaths=""
for PACKAGE in $(find ${DIR} -maxdepth 1 -mindepth 1 -type d); do
    pkg_name=$(f_get_pkg_name "$PACKAGE")
    toUpdatePaths+="{\"package_path\":\"${PACKAGE}\",\"package_name\": \"${pkg_name}\"},"
done
toUpdatePaths="{\"include\":[${toUpdatePaths::-1}]}"
echo $toUpdatePaths
