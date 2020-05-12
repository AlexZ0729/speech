Activate the python3 environment
```
conda activate project_31110
```
Clone torch repo  
```
git clone https://github.com/torch/distro.git ~/torch --recursive
```

Fix a flag on the cp command (not required for systems without NFS mounted home directories)  
```
sed -i 's/-pPR/-PR/' ~/torch/exe/luajit-rocks/luarocks/src/luarocks/fs/unix/tools.lua
```

Point torch to the Cuda install (change /usr/local/cuda to the respective Cuda installation path)
```
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

Fix an issue with newer cuda installs and torch  
```
export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"
```

Install (don't update bashrc when it asks at the end)  
```
cd ~/torch; ./install.sh
``` 

Activate torch env vars and warp-ctc vars   
```
. ~/torch/install/bin/torch-activate
```

Change to this repo directory and update the path variables 
```
source setup.sh
```

Build warp-ctc   
```
cd libs/warp-ctc
```

Fresh build (so cmake finds torch)
```
rm -rf build && mkdir build && cd build
cmake ..
make
```

Run tests for the CTC package
```
./test_cpu
./test_gpu
```
