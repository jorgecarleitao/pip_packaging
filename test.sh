#!/usr/bin/env bash

dir=$(pwd)
new_dir=${dir}/test

function _prepare_venv {
    mkdir -p ${new_dir}
    cd ${new_dir}

    echo "- creating virtualenv..."
    virtualenv --quiet -p python3 ~/.virtualenvs/pip_packaging
    source ~/.virtualenvs/pip_packaging/bin/activate
    echo "- virtualenv created"
}

function _test_packaging {
    echo "- Running tests..."
    # import and use package, sub-package and dependency
    python -c "import pip_packaging; pip_packaging.f(); import pip_packaging.sub_package; pip_packaging.sub_package.sub_f(); import requests"

    # run the script
    my_script

    # run the entry point
    my_entry_point

    echo "- Tests ran"
}

function _clean_up {
    deactivate
    cd ${dir}
    rm -rf ${new_dir}
    rm -rf ~/.virtualenvs/pip_packaging
}

function test_git_installation {
    echo "Running tests for git installation..."

    _prepare_venv

    echo "- installing package..."
    git clone ${dir} test_pip_packaging --quiet

    # install
    cd test_pip_packaging && pip install --quiet -r requirements.txt && cd ..
    echo "- package installed"

    _test_packaging

    echo "Git installation works"
    _clean_up
}

function test_source_installation {
    echo "Running tests for source installation..."

    # package it
    python setup.py  --quiet sdist

    _prepare_venv

    echo "- installing package..."
    cp ${dir}/dist/pip_packaging-0.1.tar.gz .

    pip install  --quiet pip_packaging-0.1.tar.gz
    echo "- package installed"

    _test_packaging

    echo "Source installation works"
    _clean_up
    rm -rf dist
    rm -rf pip_packaging.egg-info
}

function test_wheel_installation {
    echo "Running tests for wheel installation..."

    # package it
    python setup.py --quiet bdist_wheel

    _prepare_venv

    echo "- installing package..."
    # get the binaries
    cp ${dir}/dist/pip_packaging-0.1-py3-none-any.whl .

    # install
    pip install --quiet pip_packaging-0.1-py3-none-any.whl
    echo "- package installed"

    _test_packaging

    echo "Wheel installation works"
    _clean_up
    rm -rf build dist
    rm -rf pip_packaging.egg-info
}

test_git_installation
test_source_installation
test_wheel_installation
