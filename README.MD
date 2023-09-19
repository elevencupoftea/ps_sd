# Stable Diffusion with AUTOMATIC1111's WebUI on Paperspace

## Description
This method will deploy everything you need to quickly connect Stable Diffusion to your Paperspace notebook.

*Average initial setup time: ~ **10 minutes***\
*Re-run jypiter notebook: ~ **1 minute***

## Installation
1. Create a new project on [Paperspace Console](https://console.paperspace.com)
2. Connect to the new machine
3. Go to the **Terminals** tab and create one
4. In the terminal type the following:
   - `git clone https://github.com/elevencupoftea/ps_sd` - *Copying this repository to the /notebooks folder*
5. Switch to the **Files** tab and open notepad **ps_sd/sb.ipynb** and execute all the cells from top to bottom.\
   *The first run may take about 10 minutes, as Python 3.10 will be built from source and all dependencies will be downloaded. If notepad does not open, refresh the page and try again*
6. Wait until the last cell is loaded and a link beginning with **"tensorboard-"** appears in the output window</li>

### Cell Details
The notepad has only three sections:\
#### Prepare machine
> This block is run once. The next time you run machine, you can skip it*
- Downloading python 3.10 source code (Paperspace uses 3.9 by default)
- Building python 3.10 from the source code and copy it to ./Python (do not delete this folder, because the next time you connect to the machine, this folder will always be used).
- Creating a virtual environment in the ./venv folder (also do not delete this folder).
- Copying AUTOMATIC1111's WebGUI from https://github.com/AUTOMATIC1111/stable-diffusion-webui
- Installing dependencies.

#### Parameters
In this block you can customize your Stable Diffusion:
- Enabling API
- Selecting and downloading a third-party model (currently supported by https://civitai.com
> make sure that the selected model is downloaded completely (The download bar should reach 100%). Otherwise, you will need to delete the incompletely downloaded model at the path **./stable-diffusion/models/Stable-diffusion** 
- Enable authorization - before logging into the WebUI you will need to enter your specified data
- Downloading a standard V1.5 model
- Running on CPU or GPU

#### Start
Running Stable Diffusion, WebUI. You need to wait in the output for a link to enter the WebUI.
**Enjoy :)**





