#!/bin/bash

PROJECT_PATH="Stable"
SD_PATH="stable_diffusion"
NOTEBOOK_PATH=$(pwd)
VENV_PATH=$PROJECT_PATH/venv

function show_status(){
  echo "-------------"
  echo $1
}

# Update system
function system_update() {
  show_status "Updating System"
  sudo apt update > /dev/null 2>&1
  sudo apt install wget git -y > /dev/null 2>&1

  # Make project folder
  mkdir $PROJECT_PATH
}

function prepare_environment() {
  show_status "Preapring environment"
  cd $PROJECT_PATH || exit
  # Clone Automatic1111's WebUI
  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git ./$SD_PATH > /dev/null 2>&1

  # Create virtual environment
  /usr/local/bin/python3.10 -m venv "$NOTEBOOK_PATH"/"$VENV_PATH"

  # Install dependencies
  source "$NOTEBOOK_PATH"/"$VENV_PATH"/bin/activate
  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 > /dev/null 2>&1
  pip install matplotlib-inline ipython > /dev/null 2>&1

}

# Uninstall all
function uninstall() {
  sudo apt -qq -y remove --purge wget git python3 python3-venv
  sudo apt -qq -y autoremove
  sudo apt -qq -y autocelan
  sudo rm -rf $PROJECT_PATH
}

function make_python(){
  show_status "Building Python"
  PYTHON_VERSION="3.10.6"

  sudo apt -qq -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev liblzma-dev libsqlite3-dev wget libbz2-dev sudo apt python-is-python3 > /dev/null 2>&1
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz > /dev/null 2>&1
  tar -xvf Python-$PYTHON_VERSION.tgz > /dev/null 2>&1
  cd Python-$PYTHON_VERSION 
  sudo ./configure --enable-optimizations > /dev/null 2>&1
  sudo make -j$(nproc) > /dev/null 2>&1
  sudo make altinstall > /dev/null 2>&1
  cd ..
  sudo rm -rf Python*
}


# Exec
system_update
make_python
prepare_environment

echo "######################################################"
echo "----------------------ALL DONE------------------------"
echo "######################################################"

