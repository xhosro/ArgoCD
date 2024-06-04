#!/bin/bash

# exit when any command fails
set -e

# get the version tag from the script's first argument that it matches with git
new_ver=$1

# print out the correct version
echo "new version: $new_ver"

# Simulate release of the new docker images
docker tag nginx:1.27.0 rhosrow/nginx:$new_ver

# Push new version to dockerhub
docker push rhosrow/nginx:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
git clone git@github.com:xhosro/public-repo-gitops.git $tmp_dir

# Update image tag
sed -i '' -e "s/rhosrow\/nginx:.*/rhosrow\/nginx:$new_ver/g" $tmp_dir/my-app/1-deployment.yaml

# Commit and push
cd $tmp_dir
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
rm -rf $tmp_dir