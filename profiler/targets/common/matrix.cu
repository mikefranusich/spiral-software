/*
 *  Copyright (c) 2018-2021, Carnegie Mellon University
 *  See LICENSE for details
 */
/***************************************************************************
 * SPL Matrix                                                              *
 *                                                                         *
 * Computes matrix that corresponds to SPL generated routine               *
 ***************************************************************************/

#include <limits.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#include <cufft.h>
#include <cufftXt.h>

#include <helper_cuda.h>

#ifndef ROWS
#error ROWS must be defined
#endif
#ifndef COLUMNS
#error COLUMNS must be defined
#endif

#ifndef NZERO
#define NZERO (1.0/(double)-INFINITY)
#endif

cufftDoubleReal  *Input, *Output;
cufftDoubleReal  *dev_in, *dev_out;

void initialize(int argc, char **argv) {
	Input =  (cufftDoubleReal*) calloc(sizeof(cufftDoubleReal), COLUMNS );
	Output = (cufftDoubleReal*) calloc(sizeof(cufftDoubleReal), ROWS );

	cudaMalloc     ( &dev_in,  sizeof(cufftDoubleReal) * COLUMNS );
	cudaMalloc     ( &dev_out, sizeof(cufftDoubleReal) * ROWS );

	INITFUNC();
}

void finalize() {
	free (Output);
	free (Input);
	cudaFree     (dev_out);
	cudaFree     (dev_in);
}

void set_value_in_vector(cufftDoubleReal *arr, int elem)
{
	// Zero array and put '1' in the location indicated by element
	int idx;
	for (idx = 0; idx < COLUMNS; idx++)
		arr[idx] = (idx == elem) ? 1.0 : 0.0;

	return;
}

void compute_matrix()
{
	int x, y, indx;
	double nzero = NZERO;
	printf("[ ");
	for (x = 0; x < COLUMNS; x++) {
		set_value_in_vector(Input, x);

		cudaMemcpy ( dev_in, Input, sizeof(cufftDoubleReal) * COLUMNS, cudaMemcpyHostToDevice);
		
		for (indx = 0; indx < ROWS; indx++) {
			Output[indx] = (double)-INFINITY;
			cudaMemcpy(&dev_out[indx], &nzero, sizeof(cufftDoubleReal), cudaMemcpyHostToDevice);
			checkCudaErrors(cudaGetLastError());
		}
		
		FUNC(dev_out, dev_in);
		cudaMemcpy ( Output, dev_out, sizeof(cufftDoubleReal) * ROWS, cudaMemcpyDeviceToHost);
		
		if (x != 0) {
			printf(",\n  [ ");
		}
		else {
			printf("[ ");
		}
		for (y = 0; y < ROWS; y++) {
			if (y != 0) {
				if ((y % 10) == 0) {
					printf("\n");
				}
				printf(", ");
			}
			printf("FloatString(\"%.18g\")", Output[y]);
		}
		printf(" ]");
	}
	printf("\n];\n");
}


int main(int argc, char** argv) {
	initialize(argc, argv);
	compute_matrix();
	finalize();
	return EXIT_SUCCESS;
}
