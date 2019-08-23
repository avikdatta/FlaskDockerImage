FROM continuumio/miniconda
MAINTAINER reach4avik@yahoo.com

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
    git
    
RUN apt-get purge -y --auto-remove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

USER $NB_USER
WORKDIR /home/$NB_USER

RUN mkdir -p /home/$NB_USER/tmp
COPY environment.yaml /home/$NB_USER/environment.yaml

RUN conda env create -q --file  /home/$NB_USER/environment.yaml
RUN rm -rf /home/$NB_USER/tmp
RUN mkdir -p /home/$NB_USER/tmp
CMD [ "/bin/bash" ]
