#!/usr/bin/env bash

echo "Worker Initiated"

if [ -f "/workspace/venv/bin/activate" ]; then
    echo "Starting Automatic1111 Web UI" # Clarified message
    source /workspace/venv/bin/activate
    TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
    export LD_PRELOAD="${TCMALLOC}"
    export PYTHONUNBUFFERED=true
    export HF_HOME="/workspace" # Keep this, it points Hugging Face cache to /workspace

    python3 /workspace/stable-diffusion-webui/webui.py \
      --listen --port 7860 \
      --xformers \
      --no-half-vae \
      --skip-python-version-check \
      --skip-torch-cuda-test \
      --skip-install \
      --opt-sdp-attention \
      --disable-safe-unpickle \
      --api \
      --skip-version-check \
      --no-hashing \
      --no-download-sd-model
      # Consider adding --medvram if you encounter VRAM issues on 3070 Ti

    # Removed: deactivate (A1111 should be the primary running process)
    # Removed: > /workspace/logs/webui.log 2>&1 & (for direct terminal output)

else
    echo "ERROR: The Python Virtual Environment (/workspace/venv/bin/activate) could not be activated"
    echo "Ensure Automatic1111 has been properly installed in the image."
    # Removed RunPod specific error messages
fi

