import pkg_resources


# external dependency
import requests


def f():
    with open(pkg_resources.resource_filename(__name__, 'data_file.txt')) as f:
        return f.readlines()[0]
