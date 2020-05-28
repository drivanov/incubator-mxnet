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


