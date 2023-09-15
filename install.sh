#!/bin/bash

PROJECT_PATH="Stable"
SD_PATH="stable_diffusion"
NOTEBOOK_PATH=$(pwd)
VENV_PATH=$PROJECT_PATH/venv

# Update system
function system_update() {
  sudo apt update
  sudo apt install wget git -y
}

function prepare_environment() {
  # Make project folder
  mkdir $PROJECT_PATH
  cd $PROJECT_PATH || exit

  # Clone Automatic1111's WebUI
  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git ./$SD_PATH

  # Create virtual environment
  /usr/local/bin/python3.10 -m venv "$NOTEBOOK_PATH"/"$VENV_PATH"

  # Install dependencies
  source "$NOTEBOOK_PATH"/"$VENV_PATH"/bin/activate
  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
  pip install matplotlib-inline ipython

}

# Uninstall all
function uninstall() {
  sudo apt -qq -y remove --purge wget git python3 python3-venv
  sudo apt -qq -y autoremove
  sudo apt -qq -y autocelan

  sudo rm -rf $PROJECT_PATH
}

function make_python(){
  PYTHON_VERSION="3.10.6"
  cd $PROJECT_PATH

  sudo apt -qq -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev liblzma-dev libsqlite3-dev wget libbz2-dev sudo apt python-is-python3
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
  tar -xvf Python-$PYTHON_VERSION.tgz
  cd Python-$PYTHON_VERSION
  sudo ./configure --enable-optimizations
  sudo make -j$(nproc)
  sudo make altinstall

  cd ..
  rm -rf Python-$PYTHON_VERSION
}


# Exec
system_update
make_python
prepare_environment

echo "######################################################"
echo "ALL DONE"
echo "######################################################"

