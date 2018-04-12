import unittest

from pip_packaging import f
from pip_packaging.sub_package import sub_f


class TestBasic(unittest.TestCase):

    def test_interface(self):
        self.assertEqual(f(), 'data_file.txt')

    def test_interface_sub_package(self):
        self.assertEqual(sub_f(), 'sub_f')
