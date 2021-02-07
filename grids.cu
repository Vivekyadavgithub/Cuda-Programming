%%cu
#include <stdio.h>
#include <cuda.h>
#define N 8000  

__global__ void dkernal(){
    if(threadIdx.x == 0 && blockIdx.x == 0 &&
       threadIdx.y == 0 && blockIdx.y == 0 &&
       threadIdx.z == 0 && blockIdx.z == 0){
           printf("%d %d %d %d %d %d\n", gridDim.x, gridDim.y, gridDim.z, 
                                         blockDim.x, blockDim.y, blockDim.z);
       }
}

int main(){
    dim3 grid(2, 3, 4);
    dim3 block(5, 6, 7);
    dkernal <<<grid, block>>>();
    cudaDeviceSynchronize();
    return 0;
}
