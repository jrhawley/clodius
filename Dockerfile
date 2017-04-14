FROM ubuntu:17.04

# TODO: Combine lines when stable
RUN apt-get update
RUN apt-get install -y bedtools=2.26.0+dfsg-3
RUN apt-get install -y python2.7
RUN apt-get install -y python-pip=9.0.1-2
RUN apt-get install -y libcurl4-gnutls-dev=7.51.0-1ubuntu1 # for curl-config
RUN apt-get install -y git=1:2.10.2-3 # Needed for installs from requirements.txt
RUN apt-get install -y zlib1g-dev
#  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/root

# Copy and install just the requirements.txt, so that this cache layer isn't lost when other files are modified.
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN python setup.py install
RUN python setup.py build_ext --inplace
