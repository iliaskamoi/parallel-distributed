#!/bin/bash
#Builds the files 
sudo gcc opencilk.c -o opencilk.exe -fcilkplus -O3
sudo gcc openmp.c -o openmp.exe -fopenmp -O3
sudo gcc simple_c.c -o simple_c.exe -O3


#Test 1.632.803x1.632.803 matrix with 30.622.564 non-zero values. 
name="soc-Pokec.mtx"
N=1632803
nz=30622564
printf "threads : 1\n"
CILK_NWORKERS=1 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
CILK_NWORKERS=2 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
CILK_NWORKERS=3 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
CILK_NWORKERS=4 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
CILK_NWORKERS=8 ./opencilk.exe "$name" "$N" "$nz"


#Test 524.288x524.288 matrix with 21.781.478 non-zero values. 
name="kron_g500-logn19.mtx"
N=524288
nz=21781478
printf "threads : 1\n"
CILK_NWORKERS=1 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
CILK_NWORKERS=2 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
CILK_NWORKERS=3 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
CILK_NWORKERS=4 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
CILK_NWORKERS=8 ./opencilk.exe "$name" "$N" "$nz"


#Test 5.154.859x5.154.859 matrix with 99.199.551 non-zero values. 
name="cage15.mtx"
N=5154859
nz=99199551
printf "threads : 1\n"
CILK_NWORKERS=1 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
CILK_NWORKERS=2 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
CILK_NWORKERS=3 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
CILK_NWORKERS=4 ./opencilk.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
CILK_NWORKERS=8 ./opencilk.exe "$name" "$N" "$nz"



#Test 1.632.803x1.632.803 matrix with 30.622.564 non-zero values. 
name="soc-Pokec.mtx"
N=1632803
nz=30622564
printf "threads : 1\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
./simple_c.exe "$name" "$N" "$nz"


#Test 524.288x524.288 matrix with 21.781.478 non-zero values. 
name="kron_g500-logn19.mtx"
N=524288
nz=21781478
printf "threads : 1\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
./simple_c.exe "$name" "$N" "$nz"


#Test 5.154.859x5.154.859 matrix with 99.199.551 non-zero values. 
name="cage15.mtx"
N=5154859
nz=99199551
printf "threads : 1\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 2\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 3\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 4\n"
./simple_c.exe "$name" "$N" "$nz"
printf "\n threads : 8\n"
./simple_c.exe "$name" "$N" "$nz"


#Test 1.632.803x1.632.803 matrix with 30.622.564 non-zero values. 
name="soc-Pokec.mtx"
N=1632803
nz=30622564
printf "threads : 1\n"
./openmp.exe "$name" "$N" "$nz" 1
printf "\n threads : 2\n"
./openmp.exe "$name" "$N" "$nz" 2
printf "\n threads : 3\n"
./openmp.exe "$name" "$N" "$nz" 3
printf "\n threads : 4\n"
./openmp.exe "$name" "$N" "$nz" 4
printf "\n threads : 8\n"
./openmp.exe "$name" "$N" "$nz" 8


#Test 524.288x524.288 matrix with 21.781.478 non-zero values. 
name="kron_g500-logn19.mtx"
N=524288
nz=21781478
printf "threads : 1\n"
./openmp.exe "$name" "$N" "$nz" 1
printf "\n threads : 2\n"
./openmp.exe "$name" "$N" "$nz" 2
printf "\n threads : 3\n"
./openmp.exe "$name" "$N" "$nz" 3
printf "\n threads : 4\n"
./openmp.exe "$name" "$N" "$nz" 4
printf "\n threads : 8\n"
./openmp.exe "$name" "$N" "$nz" 8


#Test 5.154.859x5.154.859 matrix with 99.199.551 non-zero values. 
name="cage15.mtx"
N=5154859
nz=99199551
printf "threads : 1\n"
./openmp.exe "$name" "$N" "$nz" 1
printf "\n threads : 2\n"
./openmp.exe "$name" "$N" "$nz" 2
printf "\n threads : 3\n"
./openmp.exe "$name" "$N" "$nz" 3
printf "\n threads : 4\n"
./openmp.exe "$name" "$N" "$nz" 4
printf "\n threads : 8\n"
./openmp.exe "$name" "$N" "$nz" 8