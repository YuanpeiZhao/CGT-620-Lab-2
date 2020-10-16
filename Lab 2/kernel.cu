#include <cstdio>
#include <iostream>

using namespace std;

__global__ void kernelFun(void) {

	printf("Hello from block %i of %i and thread %i\n",
		blockIdx.x, blockDim.x, threadIdx.x);
}
int main() {

	kernelFun << <16, 16 >> > ();


	int devCnt = 0;
	cudaError_t error_id = cudaGetDeviceCount(&devCnt);

	int dev, driverVersion = 0, runtimeVersion = 0;
	for (dev = 0; dev < devCnt; ++dev) {
		cudaSetDevice(dev);
		cudaDeviceProp deviceProp;
		cudaGetDeviceProperties(&deviceProp, dev);

		cout << "Device " << dev << ": " << deviceProp.name << endl;
		cout << "total global memory: " << deviceProp.totalGlobalMem << endl;
		cout << "clock frequency: " << deviceProp.clockRate << endl;
		cout << "maximum number of threads per block: " << deviceProp.maxThreadsPerBlock << endl;
		cout << "maximum shared memory of a thread block: " << deviceProp.sharedMemPerBlock << endl;
		cout << "number of multiprocessors: " << deviceProp.multiProcessorCount << endl;
		cout << "l2 cache size: " << deviceProp.l2CacheSize << endl << endl;
	}

	
	return 0;
}