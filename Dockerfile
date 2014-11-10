FROM ubuntu:trusty

# gvm requires curl and unzip
RUN apt-get update && \
    apt-get install -yqq --no-install-recommends python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install newest version of awscli available
RUN pip install awscli
