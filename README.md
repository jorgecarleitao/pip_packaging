## Python packaging

This is a minimal Python package and a script to test its installation
from cloning the project (`git clone`),
a distributed source (`sdist`) or a distributed binary (`bdist`).

Running `./test.sh` runs a test using the three methods:

Installation via cloning:

1. install a virtualenv for testing
2. install the package using `git clone` and `pip install -r requirements.txt`
3. run installation tests
4. delete virtualenv and directory

Installation via distributed source:

1. package the project using `sdist` (creates a `tar.gz`)
2. copy the package to new directory
3. create virtualenv and install the package
4. run installation tests
5. delete virtualenv and directory

Installation via distributed binary:

1. package the project using `bdist_wheel` (creates a `.whl`)
2. copy the binaries to new directory
3. create virtualenv and install the package
4. run installation tests
5. delete virtualenv and directory
