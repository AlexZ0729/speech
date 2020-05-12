Create a python 3.6 environment and install the packages listed below. The commands below will work for a conda environment.

```
conda create -n project_31110 python=3.6
conda activate project_31110
```
Install pytorch version 0.4.1 following the appropriate instructions suitable for your system from [here](https://pytorch.org/get-started/previous-versions/#via-conda)
```
conda install numpy scipy jupyter matplotlib
pip install soundfile editdistance tensorboard_logger
conda install -c anaconda protobuf pytest pyyaml cmake 
conda install -c conda-forge tqdm
conda install -c conda-forge librosa
```
