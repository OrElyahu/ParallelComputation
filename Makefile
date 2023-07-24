build:
	mpicxx -fopenmp -c main.c -o main.o
	mpicxx -fopenmp -c func.c -o func.o
	nvcc -I./Common  -gencode arch=compute_61,code=sm_61 -c cudaFunc.cu -o cudaFunc.o
	mpicxx -fopenmp -o program  main.o func.o cudaFunc.o  -L/usr/local/cuda/lib -L/usr/local/cuda/lib64 -lcudart
	

clean:
	rm -f *.o ./program

runOn2:
	mpiexec -np 4 -machinefile  mf  -map-by  node  ./program
