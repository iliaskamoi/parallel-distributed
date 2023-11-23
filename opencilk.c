#include<time.h>
#include<omp.h>
#include<cilk/cilk.h>
#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "mmio.c"

struct timespec t_start, t_end;


void reader(char *file_name, int *I, int *J);


int C_generator(int * c,int  N);
void minorGraph(int nnz,int *c, int*I,int*J,int*resultI,int *resultJ);



int main(int argc, char *argv[]) {
    char *name= argv[1];
    int N=atoi(argv[2]);   
    int nz=atoi(argv[3]);
    char file[100];
    int *I = (int *) malloc(nz * sizeof(int));
    int *J = (int *) malloc(nz * sizeof(int));
    int * resultI = (int *)malloc(nz*sizeof(int));
    int * resultJ = (int *)malloc(nz*sizeof(int));
    snprintf(file, sizeof(file), "matrices/%s", name);
    reader(file, I, J);
    int * c = (int *)malloc(N*sizeof(int));
    C_generator(c, N);

    clock_gettime(CLOCK_REALTIME, &t_start);
    minorGraph(nz,c,I,J,resultI,resultJ);

    clock_gettime(CLOCK_REALTIME, &t_end);
    double duration = ((t_end.tv_sec - t_start.tv_sec) * 1000000 + (t_end.tv_nsec - t_start.tv_nsec) / 1000) / 1000000;
    printf("Duration: %lf seconds\n", duration);
}


void minorGraph(int nz,int *c, int*I,int*J,int*resultI,int *resultJ){
    cilk_for (int i = 0; i < nz; i++){
        resultJ[i] = c[J[i]];
        resultI[i] = c[I[i]];
    }
}

int C_generator(int * c,int  N){
    int m=-1;
    for (int i = 0; i < N; i++){
        c[i] = rand()%N;
        if (c[i] > m) m = c[i];
    }

}


void reader(char *file_name, int *I, int *J){
    int ret_code;
    MM_typecode matcode;
    FILE *f;
    int M, nz,N;   
    int i;
    double *val;
    if (file_name == NULL )
	{
		fprintf(stderr, "Usage:[martix-market-filename]\n");
		exit(1);
	}
    else    
    {
        if ((f = fopen(file_name, "r")) == NULL) 
        exit(1);
    }
    if (mm_read_banner(f, &matcode) != 0)
    {
        printf("Could not process Matrix Market banner.\n");
        exit(1);
    }

    if (mm_is_complex(matcode) && mm_is_matrix(matcode) && 
            mm_is_sparse(matcode) )
    {
        printf("Sorry, this application does not support ");
        printf("Market Market type: [%s]\n", mm_typecode_to_str(matcode));
        exit(1);
    }

    if ((ret_code = mm_read_mtx_crd_size(f, &M, &N, &nz)) !=0)
        exit(1);

    val = (double *) malloc(nz * sizeof(double));
    for (i=0; i<nz; i++)
    {
        fscanf(f, "%d %d \n", &I[i], &J[i]);
        I[i]--;  /* adjust from 1-based to 0-based */
        J[i]--;
    }
    if (f !=stdin) fclose(f);
    mm_write_banner(stdout, matcode);
    mm_write_mtx_crd_size(stdout, M, N, nz);
}