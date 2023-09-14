#!/bin/bash

PROJECT_PATH="Stable"
SD_PATH="stable_diffusion"
NOTEBOOK_PATH=$(pwd)
VENV_PATH=$NOTEBOOK_PATH/venv

# Update system
function system_update() {
  sudo apt update
  sudo apt install wget git python3 python3-venv python3-pip -y
}

function prepare_environment() {
  mkdir $PROJECT_PATH
  cd $PROJECT_PATH || exit

  # Clone Automatic1111's WebUI
  git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git ./$SD_PATH

  # Create virtual environment
  python3 -m venv "$NOTEBOOK_PATH"/venv

  # Install dependencies
  source "$VENV_PATH"/bin/activate
  pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/rocm5.6
  echo "Done."
}

# Uninstall all
function uninstall() {
  sudo apt -qq -y remove --purge wget git python3 python3-venv
  sudo apt -qq -y autoremove
  sudo apt -qq -y autocelan

  sudo rm -rf $PROJECT_PATH
}


# Exec
#system_update
prepare_environment

