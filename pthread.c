#include<time.h>
#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>

#include "mmio.c"

struct timespec t_start, t_end;
pthread_mutex_t mux = PTHREAD_MUTEX_INITIALIZER; 




void reader(char *file_name, int *I, int *J);


int C_generator(int * c,int  N);
void *minorGraph(void *args);
struct args{
    int N;   
    int nz;
    int *I;
    int *J;
    int * resultI;
    int * resultJ;
    int *c
};


int main(int argc, char *argv[]) {

    struct args *args = (struct args*) malloc(sizeof(struct args));

    args->N = 1632803;   
    args->nz=30622564;
    args->I = (int *) malloc(args->nz * sizeof(int));
    args->J = (int *) malloc(args->nz * sizeof(int));
    args->resultI = (int *)malloc(args->nz*sizeof(int));
    args->resultJ = (int *)malloc(args->nz*sizeof(int));
    reader("soc-Pokec.mtx", args->I, args->J);
    args->c = (int *)malloc(args->N*sizeof(int));
    C_generator(args->c, args->N);
    printf("%d \n",args->N);

    clock_gettime(CLOCK_REALTIME, &t_start);
    pthread_t ptid; 
    pthread_create(&ptid, NULL, &minorGraph, (void*)args);
    pthread_join(ptid,NULL); 
    clock_gettime(CLOCK_REALTIME, &t_end);
    double duration = ((t_end.tv_sec - t_start.tv_sec) * 1000000 + (t_end.tv_nsec - t_start.tv_nsec) / 1000) / 1000000;
    printf("~ V3 duration: %lf seconds\n", duration);
}


void *minorGraph(void *args){
    struct args *data = (struct args*)args;

    for (int i = 0; i < data->nz; i++){
        data->resultJ[i] = data->c[data->J[i]];
        data->resultI[i] = data->c[data->I[i]];
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