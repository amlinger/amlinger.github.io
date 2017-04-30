# amlinger.github.io
My Personal blog, where I write about stuff I like and personal projects.

## Development
To run the development server, there is a couple of dependencies that needs to
be resolved. Ruby 2.2.2< is needed to install all dependencies, and the Bundler
needs to be installed.

To install dependencies, run
```
bundle install
```

To run the development server with live reload, the following commands need to
be executed:
```
$ bundle exec guard
$ jekyll serve --host=0.0.0.0 --watch
```
* `Guard` will handle the live reloading of the page.
* The `--host` argument will allow the site to be accessed with other devices on
  the local network.
* The `--watch` argument will rebuild the site whenever the source files change.

This can be shortcut with `tmux` to be:
```
tmux split-window "bundle exec guard" && jekyll serve --host=0.0.0.0 --watch
```

## Build for production
This step has now been automated by Jekyll.
```
JEKYLL_ENV=production jekyll build
```
Will create the site under the `_site/` directory. Running this in the `source`
branch, checking out master, and copying/overwriting the folders contents,
then committing and pushing the contents to the `master` branch will deploy the
site.
