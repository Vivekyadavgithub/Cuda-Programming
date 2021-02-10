%%cu
#include <stdio.h>
#include <cuda.h>
#define N 5
#define M 6
__global__ void dkernal(unsigned int* matrix){
    /*if(threadIdx.x == 0 &&blockIdx.x == 0 &&
       threadIdx.y == 0 && blockIdx.y == 0 &&
       threadIdx.z == 0 && blockIdx.z == 0){
           printf("%d %d %d %d %d %d\n", gridDim.x, gridDim.y, gridDim.z, 
                                         blockDim.x, blockDim.y, blockDim.z);
       }*/
       /*int i = threadIdx.x; 
               matrix[threadIdx.y + (i * M)] = 
                                   threadIdx.y + (i * M) ;*/

        int j = threadIdx.x;
        int i = blockIdx.x;
        matrix[i * M + j] = i * M + j ; 
       
}

int main(){
    unsigned *matrix, *hmatrix;
    cudaMalloc(&matrix, N * M * sizeof(unsigned));
    hmatrix = (unsigned*)malloc(N * M * sizeof(unsigned));
    dkernal <<<N, M>>>(matrix);
    cudaMemcpy(hmatrix, matrix, N * M * sizeof(unsigned), 
                                    cudaMemcpyDeviceToHost);
    for(unsigned i = 0 ; i < N ; ++i)
    {
        for(unsigned j = 0 ; j < M ; ++j)
        {
            printf("%3d", hmatrix[i * M + j]);
        }
        printf("\n");
    }
    return 0;
}
