FROM ubuntu:16.04
MAINTAINER reach4avik@yahoo.com
LABEL maintainer="avikdatta"

ENTRYPOINT []

ENV NB_USER vmuser
ENV NB_GROUP vmuser
ENV NB_UID 1000
USER root
WORKDIR /root/

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER \
     && groupadd $NB_GROUP \
     && usermod -a -G $NB_GROUP $NB_USER

RUN apt-get -y update &&   \
    apt-get install --no-install-recommends -y \
    git \
    wget
    
RUN apt-get purge -y --auto-remove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

USER $NB_USER
WORKDIR /home/$NB_USER

RUN mkdir -p /home/$NB_USER/tmp
COPY environment.yaml /home/$NB_USER/environment.yaml
RUN  wget --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     bash Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH $PATH:/home/$NB_USER/miniconda3/bin/
RUN conda env create -q --file  /home/$NB_USER/environment.yaml
RUN echo ". /home/$NB_USER/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate flask" >> ~/.bashrc
RUN rm -rf /home/$NB_USER/tmp
RUN mkdir -p /home/$NB_USER/tmp
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
CMD [ "/bin/bash" ]
