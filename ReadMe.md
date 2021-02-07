Google colab is used by me for running this codes. To check colab nvcc --version use

! nvcc --version

To get required Resources(be sure to set runtime to gpu)

!pip install git+git://github.com/andreinechaev/nvcc4jupyter.git
%load_ext nvcc_plugin
