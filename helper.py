import requests
from tqdm import tqdm
import re
import os
# def download(url_list):
#     for url in url_list:
def get_name(response):
    filename = re.findall('filename="([^"]+)"', response.headers['Content-Disposition'])[0]
    return filename

def download(url_list, destination): 
    name_list = []
    for url in url_list:
        response = requests.get(url, stream=True)
        filename = get_name(response=response)
        if not os.path.exists(os.path.join(destination, filename)):
            print(f"Downloading {filename}")
            response.raise_for_status()
            total_size = int(response.headers.get('content-length', 0))
            block_size = 8192
            with tqdm(total=total_size, disable=False, bar_format="|{bar:50}| {percentage:3.0f}%") as progress_bar:
                with open(os.path.join(destination, filename), 'wb') as file:
                    for buffer in response.iter_content(block_size):
                        if not buffer:
                            break
                        file.write(buffer)
                        progress_bar.update(len(buffer))
                    progress_bar.close()
            print("😊")
        else:
            print(f"{filename} exists.")
        name_list.append(filename)
    return name_list[0]
        

def create_paths(START_PATH, project_folder, venv_folder):
    project_path = os.path.join(START_PATH, project_folder)
    venv_path = os.path.join(START_PATH, project_path, venv_folder)
    sd_path = os.path.join(START_PATH, project_path, "stable_diffusion")
    model_path = os.path.join(sd_path, "models", "Stable-diffusion")
    return project_path, venv_path, sd_path, model_path

if __name__ == "__main__":
    pass