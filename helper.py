import requests
from tqdm import tqdm
import re
import os


def get_name(response):
    filename = re.findall('filename="([^"]+)"', response.headers['Content-Disposition'])[0]
    return filename


def download(url_list, destination):
    if len(url_list) > 0:
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
    else:
        return False


def create_paths(start_path, project_folder, venv_folder):
    project_path = os.path.join(start_path, project_folder)
    venv_path = os.path.join(start_path, project_path, venv_folder)
    sd_path = os.path.join(start_path, project_path, "stable_diffusion")
    model_path = os.path.join(sd_path, "models", "Stable-diffusion")
    return project_path, venv_path, sd_path, model_path


def prepare_parameters(model, sd_model, username, password, api, cpu):
    params = "--port 6006 --listen --no-gradio-queue ----enable-insecure-extension-access -- --xformers"
    if model:
        params += f" --ckpt {model}"
    if not sd_model:
        params += " --no-download-sd-model"
    if api:
        params += " --api"
    if cpu:
        params += " --use-cpu all --precision full --no-half --skip-torch-cuda-test"
    else:
        params += " --opt-sub-quad-attention"
    if username != "" or password != "":
        params += f" --gradio-auth {username}:{password}"
    return params


if __name__ == "__main__":
    pass
