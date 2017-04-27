---
layout: post
title:  "Automating Jekyll builds"
date:   2017-04-28 10:00:00 +0100
categories: jekyll
---
I like automating things. That lets me do less work, and allows for less errors to slip through, and being a pretty clumsy person when when it comes to doing manual steps, such as building this site.

Github Pages is a pretty sweet place to deploy small, static websites. Unfortunately, it is not possible to use a asset pipeline, use plugins or otherwise make any changes to vanilla Jekyll and GitHub to build it for you.

Initially, I was building and deploying the site manually to the `master` branch of the repository, so that GitHub could use that as a website, while keeping the unprocessed project such as CSS and unprocessed Markdown files in the `source` branch. However, this was error prone, and I had a hard time remembering the steps between each deployment, as my posts are fairly sparse.

### Continuous Integration to the rescue!
Travis and their continuous integration engine, which is free for open source projects, now handles my deployments. Each push to the source branch triggers a build where Travis spins up a virtual machine, installs dependencies and pulls the code.

This is the `.travis.yml` file used for running the build
{% gist amlinger/5bc4783b641bdd4558f416f1e65efd9d %}

The idea is that after a successful build, the `master` branch of the project will be cloned, and Git will be configured. The files in the cloned project will be removed upon syncing files from the build directory `_site` into the repository's root. Lastly, a commit is added to the build, and the site is deployed by pushing to the `master` branch.

### Improvements to be done
The push currently uses the parent Git directory's remotes and history, so pushing with the `--hard` flag set will currently overwrite the deploy sites history. This could easily be improved by using another, non-nested directory for building the project.
