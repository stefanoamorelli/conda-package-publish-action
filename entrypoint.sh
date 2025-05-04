#!/bin/bash

set -ex
set -o pipefail

go_to_build_dir() {
    if [ ! -z $INPUT_SUBDIR ]; then
        cd $INPUT_SUBDIR
    fi
}

check_if_meta_yaml_file_exists() {
    if [ ! -f meta.yaml ]; then
        echo "meta.yaml must exist in the directory that is being packaged and published."
        exit 1
    fi
}

build_package(){
    conda config --set anaconda_upload yes
    conda build -c conda-forge -c bioconda --output-folder . .
    shopt -s nullglob
    files=(linux-64/*.tar.bz2)
    [ ${#files[@]} -gt 0 ] && conda convert -p osx-64 "${files[@]}"
}

upload_package(){
    export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN
    for f in linux-64/*.tar.bz2 osx-64/*.tar.bz2 noarch/*.conda; do
        [ -f "$f" ] && anaconda upload --label main "$f"
    done
}

go_to_build_dir
check_if_meta_yaml_file_exists
build_package
upload_package
