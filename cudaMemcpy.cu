%%cu
#include <stdio.h>
#include <cuda.h>
#define N 8000  

__global__ void fun(int *arr){
    unsigned id = threadIdx.x;
    if(id < N) arr[id] = 0;
}

__global__ void check(int* arr){
    unsigned id = threadIdx.x;
    if(id < N) arr[id] += id;
} 

int main(){
    int *da;
    int i;
    int a[N];
    cudaMalloc(&da, N * sizeof(int));
    fun<<<1, N>>>(da);
    check<<<1, N>>>(da); 
    cudaMemcpy(a, da, N * sizeof(int), cudaMemcpyDeviceToHost);
    for(i = 0 ; i < N ; ++i)
    {
        printf("%d ", a[i]);
    }
    return 0;
}
