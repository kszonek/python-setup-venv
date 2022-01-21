#!/bin/bash

#
# Updated:    2021-11-15
# Author:     kszonek
# License:    GPL v3
# Repository: https://github.com/kszonek/python-setup-venv
#

venvdir=".venv"

for pkg in python3-pip python3-venv
do
    if ! dpkg -s $pkg &> /dev/null
    then
        echo "ERROR: Please install $pkg"
        echo "   # sudo apt install $pkg"
        return
    fi
done

if [[ "$VIRTUAL_ENV" == "$venvdir" ]]
then
    echo "Python Virtual Environment already activated in $venvdir"
    return
fi

if [[ "$VIRTUAL_ENV" != "" ]]
then
    echo "Deactivating previous Python Virtual Environment in $VIRTUAL_ENV"
    deactivate
fi

if [[ ! -d $venvdir ]]
then
    echo "Creating Python Virtual Environment in $venvdir"
    python3 -m venv $venvdir
else
    echo "Python Virtual Environment already exists"
fi

echo "Activating Python Virtual Environment in $venvdir"
. $venvdir/bin/activate

echo "Updating pip"
pip3 install --upgrade pip

echo "Installing requirements"
pip3 install -r requirements.txt
