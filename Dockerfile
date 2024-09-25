FROM ubuntu:latest
LABEL authors="shush"

# install python3.11, git, nvidia-cuda-toolkit, libgl1-mesa-glx
RUN apt-get update && \
    apt -y install python3.11 python3.11-venv && \
    python --version && \
    apt -y install nvidia-cuda-toolkit libgl1-mesa-glx \
 \
    # setup git and pull SimpleTuner
RUN git config --global user.name "your-username" && \
    git config --global user.email "your-email@example.com" && \
    git clone --branch=release https://github.com/bghira/SimpleTuner.git

# go into the folder and setup venv
RUN cd SimpleTuner && \
    python3.11 -m venv .venv

# activate venv, install poetry and dependencies
RUN /bin/bash -c "source .venv/bin/activate && \
                  pip install -U poetry pip && \
                  pip install optimum-quanto && \
                  poetry install"



ENTRYPOINT ["top", "-b"]