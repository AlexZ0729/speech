#!/bin/bash
# Run `source setup.sh` from this directory.

. ~/torch/install/bin/torch-activate

export PYTHONPATH=`pwd`:`pwd`/libs/warp-ctc/pytorch_binding:`pwd`/libs:$PYTHONPATH

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/libs/warp-ctc/build
