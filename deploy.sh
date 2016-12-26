#!/bin/bash

# Clean out the existing build, and build a new site.
rm -rf _site
JEKYLL_ENV=production jekyll build

# Move to master branch, and remove the existing stuff.
git checkout master
ls | grep -v _site | xargs rm -rf
rm -rf .sass-cache .asset-cache

# Move what is in our newly built site folder to the base folder, and then
# remove the existing one.
mv _site/* .
rm -rf _site

# Create a deployment commit, and push it to GitHub.
git add .
git commit -m "Deployed site."
git push origin master

# Checkout the source branch again.
git checkout source
