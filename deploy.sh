#!/bin/bash

# Step 1: Get the latest release tag
latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))

echo "Checking out the latest release tag: $latest_tag"
git checkout $latest_tag

# Step 2: Build the Docker image
echo "Building the Docker image..."
docker build -t python-web-app:$latest_tag .

# Step 3: Stop and remove any existing container
echo "Stopping and removing old container..."
docker stop my-python-web-app 2>/dev/null || true
docker rm my-python-web-app 2>/dev/null || true

# Step 4: Run the new container
echo "Starting the new container..."
docker run -d -p 5000:5000 --name my-python-web-app python-web-app:$latest_tag

# Step 5: Print the container's IP address
ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-python-web-app)
echo "Container is running at IP address: $ip"

