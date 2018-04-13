#!/usr/bin/env bash

dir=$(pwd)

echo "Running tests for dev installation..."

cd ~

virtualenv -p python3 ~/.virtualenvs/pip_packaging
source ~/.virtualenvs/pip_packaging/bin/activate

# get the source code
git clone $dir test_pip_packaging
cd test_pip_packaging

# install
pip install -r requirements.txt

# test import modules
python -c "import pip_packaging; pip_packaging.f(); import pip_packaging.sub_package; pip_packaging.sub_package.sub_f()"

# test run the script
my_script

# test run the entry point
my_entry_point

# cleanup
echo "dev tests done"
deactivate
rm -rf ~/.virtualenvs/pip_packaging
rm -rf test_pip_packaging
cd $dir

echo "Running tests for source distribution..."

# package it
rm -rf dist
python setup.py sdist

cd ~

mkdir test_pip_packaging
cd test_pip_packaging
virtualenv -p python3 ~/.virtualenvs/pip_packaging
source ~/.virtualenvs/pip_packaging/bin/activate

# get the distributed source
cp $dir/dist/pip_packaging-0.1.tar.gz .

# install
pip install pip_packaging-0.1.tar.gz

# import modules
python -c "import pip_packaging; pip_packaging.f(); import pip_packaging.sub_package; pip_packaging.sub_package.sub_f()"

# run the script
my_script

# run the entry point
my_entry_point


# cleanup virtualenv
echo "distribution tests done"
deactivate
rm pip_packaging-0.1.tar.gz
rm -rf pip_packaging-0.1
rm -rf ~/.virtualenvs/pip_packaging

cd $dir

echo "Running tests for wheel installation..."

# package it
rm -rf dist
python setup.py bdist_wheel

cd ~

mkdir test_pip_packaging
cd test_pip_packaging
virtualenv -p python3 ~/.virtualenvs/pip_packaging
source ~/.virtualenvs/pip_packaging/bin/activate

# get the binaries
cp $dir/dist/pip_packaging-0.1-py3-none-any.whl .

# install
pip install pip_packaging-0.1-py3-none-any.whl

# import modules
python -c "import pip_packaging; pip_packaging.f(); import pip_packaging.sub_package; pip_packaging.sub_package.sub_f()"

# run the script
my_script

# run the entry point
my_entry_point


# cleanup virtualenv
echo "distribution tests done"
deactivate
rm pip_packaging-0.1-py3-none-any.whl
rm -rf ~/.virtualenvs/pip_packaging

cd $dir
