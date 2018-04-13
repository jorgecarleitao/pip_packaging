from setuptools import setup, find_packages

setup(
    name='pip_packaging',
    version='0.1',
    install_requires=[
        'requests==2.18.4',
    ],
    scripts=['bin/my_script'],

    entry_points={
        'console_scripts': ['my_entry_point=pip_packaging.entry_point:main'],
    },

    packages=find_packages(exclude=['tests']),
    package_data={
        'pip_packaging': ['data_file.txt'],
    },
)
