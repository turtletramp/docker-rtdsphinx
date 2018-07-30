# docker-sphinx
A python3 dockerfile/image with an opinionated set of extensions for using [Sphinx](http://sphinx-doc.org/) to generate ReadTheDocs-style (and format) documentation.
This work is based on:
* https://github.com/cloudcompass/docker-rtdsphinx
* https://github.com/plaindocs/docker-sphinx

## Extensions and Tools

Includes extensions for:

* locally generating the [ReadTheDocs theme](https://github.com/rtfd/sphinx_rtd_theme)
* including embedded plantuml documentation in docstrings
* [pylint](https://github.com/PyCQA/pylint) and with it, pyreverse. pyreverse can generate class diagrams for python modules.

### Note
To reduce the docker image size the sphinx latex support was removed from the original cloudcompass/docker-rtdsphinx image

## Prerequisites

* An operational Docker installation
* Currently in the root folder of the repo of the project for which you want to generate documentation 

The running of the script will create a "docs" directory in the current directory if one does not exist.

## How to Use Image: **rtdgen** bash script

The included bash shell script "**rtdgen**" is a wrapper around the docker command (below) to run "typical" document generation steps. It's not necessary, but it's a nice helper to eliminate typing long docker run commands.

**Installation**: Suggest downloading the bin/rtdgen file to a directory on your path.  Alternatively, fork/clone the repo and add the "bin" directory to your path or create a link to the file within a directory already on your path.  So many options. 

**Running**: The script expects you are running the command from the root of your repos - above the docs/ folder where the sphinx code and configuration files can be found.

Example usage:

```
   rtdgen help  # get usage information on the command
    rtdgen html # clean out and generate html via sphinx
    rtdgen view # Open the root generated html file
    rtdgen clean # clean the generated html
    rtdgen sphinx-quickstart # Run the sphinx quickstart tool
    rtdgen cli # Run the docker container and start a bash shell
```

That last command starts a shell in the container, allowing you to do whatever you need in the container from the command line.

The rtdgen script includes some awareness of the platform (windows, mac, linux) and tries to handle those differences.

## How to Use Image - Docker directly

Basic usage is from a docker-enabled system is, while in the root directory of your project repo run:

    docker run -it --rm -v <your directory>:/documents/ cloudcompass/docker-rtdsphinx

Running like this starts a bash shell in the docs directory within <your directory>. Use the included bash script rtdgen (see below) as a command line wrapper to run typical sphinx generation commands so you don't have type the full "docker run..." command every time.

## Getting Started

If you have never used sphinx on the project, you will want to look at the documentation and the [Sphinx tutorial](http://sphinx-doc.org/tutorial.html).  The basic steps using this image/script are:

* ```rtdgen sphinx-quickstart``` # interactively set up your project - make sure you say yes to autodoc, at least
* ```rtdgen sphinx-apidoc <path to code>``` # Generate an rst file listing the modules in your project
    * For example: ```rtdgen sphinx-apidoc src/agent/``` to process the code in the src/agent folder
    * Repeat for each package 
    * Update/edit the file as the structure of your project changes
* Edit the generated docs/source/conf.py file to at least:
    * Include paths to your source code usually "../.." or "../../src" or whatever
    * Include the extensions to be used - some of the ones here are NOT set in the generated ```conf.py``` file - including sphinx-rtd-theme and plantuml
    * Change the theme from "alabaster" to "sphinx-rtd-theme
* Edit the ```index.rst``` file to include the "modules.rst" file generated during the sphinx apidoc step. Careful of the indentation!
* ```rtdgen html``` # generate the html version of the documentation
    * Look for errors or warnings in the output of the generator and fix them
    * For calls to external (likely c-callable) libraries, add them to the list at the end of the conf.py, per the example conf.py
* ```rtdgen view``` # Open a browser window at the root of the generated documentation

## Notes

The workdir for the image is "docs" within <your directory>, based on the assumption that you are running this from the root of a git repo and that your sphinx setup is in docs/. Within that should be:

* ```source``` # the Sphinx documentation
* ```build``` # .gitignore'd directory into which the documentation is generated

In the simplest (and expected usage) the generated code is created in <your directory>/docs/build/html, so opening up index.html in that folder opens the root of the documentation.  That is exactly what the "**rtdgen view**" command does.

## Example

The file "example.conf.py" has the updates necessary to a (fairly generic) conf.py generated by the "sphinx-quickstart" command to use the extensions packaged in this container. Use it directly, or diff it with the generated conf.py to see what needs to be added to your version of the file. 

The built container is available at the [Docker Hub](https://registry.hub.docker.com/u/cloudcompass/docker-rtdsphinx/).
