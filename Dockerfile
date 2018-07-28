# Format: FROM    repository[:version]
# FROM       ubuntu:16.04
FROM python:3.6-stretch

# Usage:
# docker run -it -v <your directory>:/documents/

ENV DEBIAN_FRONTEND noninteractive

# Update apt-get sources AND install stuff
RUN apt-get update && apt-get install -y -q \
    texlive \
    texlive-latex-extra \
    pandoc \
    build-essential \
    plantuml

RUN pip3 install \
    sphinx \
    sphinx_rtd_theme\
    pylint\
    aiohttp \
    sphinxcontrib-plantuml

RUN mkdir /documents

VOLUME /documents
WORKDIR /documents/docs

CMD ["/bin/bash"]