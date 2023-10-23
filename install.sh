#!/bin/bash

PROJECT_PATH="Stable"
SD_PATH="stable_diffusion"
NOTEBOOK_PATH=$(pwd)
VENV_PATH=$PROJECT_PATH/venv
PYTHON_PATH=$NOTEBOOK_PATH/$PROJECT_PATH/Python

function show_status(){
  echo "-------------"
  echo $1
}

# Update system
function system_update() {
  show_status "Updating System"
  rm -rf ps_sd
  sudo apt update > /dev/null 2>&1
  sudo apt install wget git curl -y > /dev/null 2>&1

  # Make project folder
  mkdir $PROJECT_PATH
}

function prepare_environment() {
  show_status "Preapring environment. Be patient. This may take about 5 minutes"
  cd $PROJECT_PATH || exit
  # Clone Automatic1111's WebUI
  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git ./$SD_PATH > /dev/null 2>&1

  # Create virtual environment
  $PYTHON_PATH/bin/python3.10 -m venv "$NOTEBOOK_PATH"/"$VENV_PATH"

  # Install dependencies
  source "$NOTEBOOK_PATH"/"$VENV_PATH"/bin/activate
  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 --no-cache-dir > /dev/null 2>&1
  pip install matplotlib-inline ipython tqdm requests > /dev/null 2>&1
  pip install -r "$SD_PATH"/requirements_versions.txt > /dev/null 2>&1
  pip install xformers==0.0.23.dev657 > /dev/null 2>&1

}

# Uninstall all
function uninstall() {
  sudo apt -qq -y remove --purge wget git python3 python3-venv
  sudo apt -qq -y autoremove
  sudo apt -qq -y autocelan
  sudo rm -rf $PROJECT_PATH
}

function make_python(){
  show_status "Building Python. Be patient. This may take about 5 minutes"
  PYTHON_VERSION="3.10.12"

  sudo apt -qq -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev liblzma-dev libsqlite3-dev wget libbz2-dev sudo apt python-is-python3 > /dev/null 2>&1
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz > /dev/null 2>&1
  tar -xvf Python-$PYTHON_VERSION.tgz > /dev/null 2>&1
  cd Python-$PYTHON_VERSION 
  sudo ./configure --enable-optimizations --prefix=$PYTHON_PATH > /dev/null 2>&1
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

