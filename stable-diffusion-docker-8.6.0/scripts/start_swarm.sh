#!/usr/bin/env bash
export PYTHONUNBUFFERED=1 # Ensures Python output is unbuffered
echo "SwarmUI: Starting SwarmUI Web UI"

# Navigate to the SwarmUI installation directory
# Assuming SwarmUI is installed at /SwarmUI as per our Dockerfile discussion
cd /SwarmUI

# Set up logging directory if it doesn't exist
# SwarmUI might have its own logging mechanism, but good to have a general one.
mkdir -p /workspace/logs

# Launch SwarmUI
# The --launch_mode none argument prevents SwarmUI from trying to open a browser window
# The --host 0.0.0.0 makes it accessible from outside the container
# The --port 7801 is SwarmUI's default port.
# nohup ... & sends the process to the background and prevents it from dying if the shell exits.
# > /workspace/logs/swarmui.log 2>&1 redirects stdout and stderr to a log file.
nohup ./launch-linux.sh --launch_mode none --host 0.0.0.0 --port 7801 > /workspace/logs/swarmui.log 2>&1 &

echo "SwarmUI: SwarmUI Web UI started"
echo "SwarmUI: Log file: /workspace/logs/swarmui.log"

# Optional: You might want to add a brief sleep here to give SwarmUI a moment to start
# before the main `docker-compose up` command thinks it's done.
sleep 5 # Adjust as needed

# In your main `scripts/start.sh` (the one called by docker-compose),
# you would then call this script.
# For example:
# nohup /scripts/start_swarm.sh &
# And then add `tail -f /dev/null` in the main start.sh to keep the container alive.
