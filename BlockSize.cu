%%cu
#include <stdio.h>
#include <cuda.h>
#define BLOCKSIZE 1024
__global__ void dkernal(unsigned *vector, unsigned vectorsize)
{
    unsigned id = blockIdx.x * blockDim.x + threadIdx.x;
    if(id < vectorsize) vector[id] = id;
}  

int main(int nn, char *str[])
{
    unsigned N = 1025; //atoi(str[1]);
    unsigned *vector, *hvector;
    cudaMalloc(&vector, N * sizeof(unsigned));
    hvector = (unsigned*)malloc(N * sizeof(unsigned));
    
    unsigned nblocks = ceil((float)N/BLOCKSIZE);
    printf("nblocks = %d\n", nblocks);
 
    dkernal<<<nblocks, BLOCKSIZE>>>(vector, N);
    cudaMemcpy(hvector, vector, N * sizeof(unsigned), cudaMemcpyDeviceToHost);
    for(unsigned i = 0 ; i < N ; ++i)
    {
        printf("%6d", hvector[i]);
    }
    return 0;
}
