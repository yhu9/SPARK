mamba create -n SPARK python=3.9
conda activate SPARK

# Environment cuda libraries
mamba install -n SPARK -c "nvidia/label/cuda-11.7.0" cuda-toolkit -y
mamba install -n SPARK -c nvidia libcusparse-dev libcusolver-dev -y
mamba install -n SPARK -c conda-forge gxx_linux-64=11 gcc_linux-64=11 -y
export CC=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-gcc
export CXX=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++
export NVCC_PREPEND_FLAGS="-ccbin $CXX"
export CUDA_HOME=$CONDA_PREFIX
# which nvcc && nvcc --version

#################### MultiFLARE ####################

# PyTorch + Pytorch3d
mamba install -n SPARK pytorch=1.13.0 torchvision=0.14.0 pytorch-cuda=11.7 -c pytorch -c nvidia -y
mamba install -n SPARK iopath -c iopath -y
# Pin torch/pytorch-cuda and add the pytorch/nvidia channels so the solver can't downgrade torch
mamba install -n SPARK pytorch3d pytorch=1.13.0 pytorch-cuda=11.7 -c pytorch3d -c pytorch -c nvidia -c conda-forge -y
pip install numpy==1.23

# nvdiffrast
pip install setuptools wheel ninja
pip install git+https://github.com/NVlabs/nvdiffrast.git --no-build-isolation
pip install --no-build-isolation git+https://github.com/NVlabs/tiny-cuda-nn#subdirectory=bindings/torch

pip install gpytoolbox opencv-python meshzoo trimesh matplotlib chumpy lpips configargparse open3d wandb
pip install xatlas
pip install git+https://github.com/jonbarron/robust_loss_pytorch

#################### TrackerAdaptation ####################

# Many of these dependencies are not used - they are here so we can import the code of DECA/EMOCA without errors.
pip install mediapipe==0.10.11
pip install timm~=0.9.16 adabound~=0.0.5 compress-pickle~=1.2.0 face-alignment==1.3.4 facenet-pytorch~=2.5.1 imgaug==0.4.0 albumentations==1.4.8 scikit-video==1.1.11
mamba install -n SPARK omegaconf~=2.0.6 pytorch-lightning==1.4.9 torchmetrics==0.6.2 hickle==5.0.2 munch~=2.5.0 torchfile==0.1.0 -c conda-forge -y

############################################################

# We need a specific version of numpy to pickle-load FLAME.
# However, our dependencies have likely upgraded numpy, so we need to reinstall the correct version.
# This will probably throw a warning.
pip install numpy==1.23

# For downloading pre-trained models
pip install gdown
