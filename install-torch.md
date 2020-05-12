Clone torch repo  
`git clone https://github.com/torch/distro.git ~/torch --recursive`

Fix a flag on the cp command (not required for systems without NFS mounted home directories)  
`sed -i 's/-pPR/-PR/' ~/torch/exe/luajit-rocks/luarocks/src/luarocks/fs/unix/tools.lua`

Point torch to the Cuda install (change /usr/local/cuda to the respective Cuda installation path)
```
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

Fix an issue with newer cuda installs and torch  
`export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"`

Install  
`cd ~/torch; ./install.sh` (don't update bashrc when it asks at the end)

# activate torch env vars and warp-ctc vars
. ~/torch/install/bin/torch-activate (you should look at this file)
cd /share/data/speech/Data/ttic31110/course_project/speech
source setup.sh

# build warp-ctc
cd libs/warp-ctc
# fresh build (so cmake finds torch)
rm -rf build && mkdir build && cd build
cmake ..
make

# test
(ta_31110_awni) [ankitap@gpu1 build]$ ./test_gpu
Running GPU tests
Tests pass
