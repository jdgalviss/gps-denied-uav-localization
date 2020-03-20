FROM floydhub/pytorch:0.3.0-py3.24


COPY deep_feat /usr/src/app/deep_feat
COPY optimize /usr/src/app/optimize
COPY requirements.txt .

RUN /bin/bash -c ". /opt/conda/etc/profile.d/conda.sh; conda activate; pip install -r requirements.txt"
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt install -y libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && pip install 'prompt-toolkit<2.0.0,>=1.0.15' --force-reinstall \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

# ENV  PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.5/dist-packages
ENV  PYTHONPATH=$PYTHONPATH:/usr/src/app/deep_feat
COPY Test.ipynb /usr/src/app/Test.ipynb
WORKDIR /usr/src/app
# Set the default command to python3
#CMD [". /opt/conda/etc/profile.d/conda.sh && conda activate"]
