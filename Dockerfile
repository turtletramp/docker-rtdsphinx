# Format: FROM    repository[:version]
FROM       ubuntu:16.04

# Usage:
# docker run -it -v <your directory>:/documents/

ENV DEBIAN_FRONTEND noninteractive

# Update apt-get sources AND install stuff
RUN apt-get update && apt-get install -y -q \
    python3 \
    texlive \
    texlive-latex-extra \
    pandoc \
    build-essential \
    python3-pip \
    plantuml

RUN pip3 install \
    sphinx \
    sphinx_rtd_theme\
    pylint\
    sphinxcontrib-plantuml

RUN mkdir /documents

VOLUME /documents
WORKDIR /documents/docs

CMD ["/bin/bash"]