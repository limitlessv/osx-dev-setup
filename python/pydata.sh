#!/usr/bin/env bash

# ~/pydata.sh

cd "$(dirname "${BASH_SOURCE}")";

# Permission denied: '/Library/Python/2.7/site-packages
# In some of the vanila setup the premisions need to be fix
sudo chown -R $USER /Library/Python/


# Install Python
brew install python
brew install python3


# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "------------------------------"
echo "Setting up pip."

# Install pip
easy_install pip

###############################################################################
# Virtual Enviroments                                                         #
###############################################################################

echo "------------------------------"
echo "Setting up virtual environments."

# Install virtual environments globally
# It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
export PIP_REQUIRE_VIRTUALENV=false

#
# https://stackoverflow.com/questions/31900008/oserror-errno-1-operation-not-permitted-when-installing-scrapy-in-osx-10-11
#
pip install --ignore-installed six

pip install virtualenv
pip install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

EXTRA_PATH=~/.extra
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH

echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Pip should only run if there is a virtualenv currently activated" >> $EXTRA_PATH
echo "export PIP_REQUIRE_VIRTUALENV=true" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH

echo "" >> $BASH_PROFILE_PATH
source $EXTRA_PATH

/var/folders










###############################################################################
# Python 2 Virtual Enviroment                                                 #
###############################################################################

echo "------------------------------"
echo "Setting up py27virtual environment."

# Create a Python2 data environment
mkvirtualenv py27
workon py27

# Install Python data modules
pip install numpy
pip install scipy
pip install matplotlib
pip install pandas
pip install sympy
pip install nose
pip install unittest2
pip install seaborn
pip install scikit-learn
pip install "ipython[all]"
pip install bokeh
pip install Flask
pip install sqlalchemy
pip install mysql-python

###############################################################################
# Python 3 Virtual Enviroment                                                 #
###############################################################################

echo "------------------------------"
echo "Setting up py36 virtual environment."

# Create a Python3 data environment
mkvirtualenv --python=/usr/local/bin/python3 py36
workon py36

# Install Python data modules
pip install numpy
pip install scipy
pip install matplotlib
pip install pandas
pip install sympy
pip install nose
pip install unittest2
pip install seaborn
pip install scikit-learn
pip install "ipython[all]"
pip install bokeh
pip install Flask
pip install sqlalchemy
#pip install mysql-python  # Python 2 only, use mysqlclient instead
pip install mysqlclient

###############################################################################
# Install IPython Profile
###############################################################################

echo "------------------------------"
echo "Installing IPython Notebook Default Profile"

# Add the IPython profile
mkdir -p ~/.ipython
cp -r ../init/profile_default/ ~/.ipython/profile_default

echo "------------------------------"
echo "Script completed."
echo "Usage: workon py27 for Python2"
echo "Usage: workon py36 for Python3"
cd ..