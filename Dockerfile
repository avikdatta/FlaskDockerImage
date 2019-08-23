FROM continuumio/miniconda
MAINTAINER reach4avik@yahoo.com

ENTRYPOINT []

ENV NB_USER vmuser
USER $NB_USER
WORKDIR /home/$NB_USER

RUN mkdir -p /home/$NB_USER/tmp
COPY environment.yaml /home/$NB_USER/environment.yaml

RUN conda env create -n -q --file  /home/$NB_USER/environment.yaml -y
RUN rm -rf /home/$NB_USER/tmp
RUN mkdir -p /home/$NB_USER/tmp
CMD [ "/bin/bash" ]
