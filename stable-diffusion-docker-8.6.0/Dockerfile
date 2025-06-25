# Stage 1: Base Image
ARG BASE_IMAGE=ashleykza/a1111:1.10.0.post7
FROM ${BASE_IMAGE} AS base

ARG INDEX_URL

# Stage 2: InvokeAI Installation
FROM base AS invokeai-install
ARG INVOKEAI_VERSION
ARG INVOKEAI_TORCH_VERSION
ARG INVOKEAI_XFORMERS_VERSION
WORKDIR /
COPY --chmod=755 build/install_invokeai.sh ./
RUN /install_invokeai.sh && rm /install_invokeai.sh

# Copy InvokeAI config file
COPY invokeai/invokeai.yaml /InvokeAI/

# Stage 3: ComfyUI Installation
FROM invokeai-install AS comfyui-install
ARG COMFYUI_COMMIT
ARG COMFYUI_TORCH_VERSION
ARG COMFYUI_XFORMERS_VERSION
WORKDIR /
COPY --chmod=755 build/install_comfyui.sh ./
RUN /install_comfyui.sh && rm /install_comfyui.sh

# Copy ComfyUI Extra Model Paths (to share models with A1111)
COPY comfyui/extra_model_paths.yaml /ComfyUI/

# Assuming your base image has curl or wget
# Install .NET 8 Runtime (adapt for your base OS, e.g., Ubuntu 22.04)
FROM comfyui-install AS swarmui-install # New stage after InvokeAI (or ComfyUI)

# Install apt dependencies for .NET (consult Microsoft's official docs for exact list)
# This might include: apt-transport-https, dotnet-sdk-8.0 (if installing SDK for compile), or aspnetcore-runtime-8.0
# For a runtime-only environment:
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \
    chmod +x ./dotnet-install.sh && \
    ./dotnet-install.sh --channel 8.0 --runtime dotnet && \
    rm dotnet-install.sh
ENV PATH="/root/.dotnet:$PATH" # Add dotnet to PATH

# --- Continue with SwarmUI specific installation ---
WORKDIR /SwarmUI

# Clone SwarmUI
RUN git clone https://github.com/mcmonkeyprojects/SwarmUI.git .

# Run the Linux installation script
# This script will typically set up its Python venv and install dependencies.
# Check the contents of launch-linux.sh or install-linux.sh first!
# You might need to customize it to not start the UI immediately,
# or ensure it installs into /SwarmUI/venv for consistency.
RUN ./install-linux.sh --auto-accept --skip-launch # Example flags, check actual script
# Or if install-linux.sh doesn't offer --skip-launch, you might need to
# execute the Python installation steps manually here if the script
# directly tries to launch the UI.

# Configure SwarmUI (this might be done by config files or environment vars)
# Ensure it's set to use A1111 and ComfyUI as backends.
# This often happens via initial web setup, but you might need to pre-configure.
# For example, ensure it expects A1111 on localhost:7860 and ComfyUI on localhost:8188

# ... continue to final stage
FROM swarmui-install AS final

# Stage 4: Finalise Image
#FROM comfyui-install AS final

# Remove existing SSH host keys
RUN rm -f /etc/ssh/ssh_host_*

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Set the main venv path
ARG VENV_PATH
ENV VENV_PATH=${VENV_PATH}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
