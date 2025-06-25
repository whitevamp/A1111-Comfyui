variable "REGISTRY" {
    default = "docker.io"
}

variable "REGISTRY_USER" {
    default = "whitevamp"
}

variable "APP" {
    default = "stable-diffusion-webui"
}

variable "RELEASE" {
    default = "8.6.0"
}

variable "CU_VERSION" {
    default = "124"
}

variable "BASE_IMAGE_REPOSITORY" {
    default = "ashleykza/a1111"
}

variable "BASE_IMAGE_VERSION" {
    default = "1.10.1"
}

variable "PYTHON_VERSION" {
    default = "3.10"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/${APP}:${RELEASE}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "${BASE_IMAGE_REPOSITORY}:${BASE_IMAGE_VERSION}"
        INDEX_URL = "https://download.pytorch.org/whl/cu${CU_VERSION}"

        KOHYA_VERSION = "v25.2.0"
        KOHYA_TORCH_VERSION = "2.6.0+cu${CU_VERSION}"
        KOHYA_XFORMERS_VERSION = "0.0.29.post3"

        COMFYUI_VERSION = "v0.3.41"
        COMFYUI_TORCH_VERSION = "2.6.0+cu${CU_VERSION}"
        COMFYUI_XFORMERS_VERSION = "0.0.29.post3"

        VENV_PATH = "/workspace/venvs/a1111"
    }
}
