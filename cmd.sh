#!/bin/bash

cd /opt/mxnet
rm /usr/local/lib/libmxnet.so
if [ -z "$2" ]; then
    cp make/config.mk .
    echo "USE_CUDA=1" >>config.mk
    echo "USE_CUDA_PATH=/usr/local/cuda" >>config.mk
    echo "USE_CUDNN=1" >>config.mk
    echo "USE_NVTX=1" >>config.mk
    echo "USE_NCCL=1" >>config.mk
    echo "USE_MKLDNN=1" >>config.mk
    echo "USE_BLAS=openblas" >> config.mk
fi

rm build/src/operator/contrib/fft.*
make -j$(nproc) 
cd python; pip install -e .; pip install minpy; cd -
pip install numpy==1.16.1
pip install gluonnlp
#  pip install --upgrade mxnet>=1.3.0

export PYTHONPATH=/opt/mxnet/gluon-nlp/src
# DATA='/opt/mxnet/gluon-nlp/scripts/bert/len_128_part-000.npz'
# cd gluon-nlp/scripts/bert

apt-get update && apt-get install unzip
pip install nose nose-timer

pip install scipy

# /opt/mxnet/tests/python/unittest/test_gluon_utils.py needs the module mock.
# If it's not there already in unittest (python 3.3 or later), it must be installed.
python -c "import unittest.mock as mock" &> /dev/null || pip install mock

export MXNET_STORAGE_FALLBACK_LOG_VERBOSE=0
export MXNET_USE_TENSORRT=0


