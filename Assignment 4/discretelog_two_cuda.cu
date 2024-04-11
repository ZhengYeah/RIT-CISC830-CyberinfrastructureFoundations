// Enumberate x to compute A^x % M using Binary Exponentiation
// Split [M] into [0, M/2] and [M/2, M] then use two CUDA

#include <cstdio>
#include <cuda_runtime_api.h>
#include <stdio.h>
#include <omp.h>

__device__ void fast_power(long long base, long long exp, long long B,
                           long long M, long long *result) {
  long long exp_backup = exp;
  __int128_t power_res = 1, base_tmp = base;
  while (exp > 0) {
    if (exp & 1)
      power_res = power_res * base_tmp % M;
    base_tmp = base_tmp * base_tmp % M;
    exp >>= 1;
  }
  if (power_res == B) {
    result[0] = exp_backup;
  }
}

__global__ void discretelog_cuda(long long base, long long B, long long M_start, long long M_end, long long M, long long *result) {
  long long id = M_start + blockIdx.x * blockDim.x + threadIdx.x;
  if (id < M_end) {
    fast_power(base, id, B, M, result);
  }  
}

__global__ void initialize_flag(int *stop_flag) {
    if (threadIdx.x == 0 && blockIdx.x == 0) {
        *stop_flag = 0;
    }
}

int main(int argc, char **argv) {
  int num_GPU = 8;
  long long A = 75052, B = 2375654730, M = 10000000019;


  long long *result_cpu = (long long*) malloc(num_GPU * sizeof(long long)); 
  long long *result_cuda[num_GPU];

  for (int i = 0; i < num_GPU; ++i) {
    cudaSetDevice(i);
    cudaMalloc((void **)&result_cuda[i], sizeof(long long));
  }

  int BLOCK_SIZE = 1024;
  long long gridSize = (long long) M / BLOCK_SIZE + 1;

  for (int i = 0; i < num_GPU; ++i) {
    cudaSetDevice(i);
    discretelog_cuda<<<gridSize, BLOCK_SIZE>>>(A, B, M/num_GPU*i, M/num_GPU*(i+1), M, result_cuda[i]);
    cudaMemcpy(result_cpu + i, result_cuda[i], sizeof(long long), cudaMemcpyDeviceToHost);
    if (result_cpu[i] != 0) {
      printf("%lld\n", result_cpu[i]);
    }
  }

  for (int i = 0; i < num_GPU; ++i) {
    cudaSetDevice(i);
    cudaFree(result_cuda[i]);
  }
  free(result_cpu);
  return 0;
}
