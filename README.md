In order to run the programm use the `run.sh` script and change the name of the file as well as the `N` and `nz` variables. `N` is the size of the array and `nz` the number of non-zero values.

Matrices should have the `.mtx` extension and contained within the `matrices` directory.

After changing the `run.sh` file, simply build it with `sudo chmod +x run.sh` and run it using `./run.sh`.

You should see something like the following:
```
threads : 1
%%MatrixMarket matrix coordinate pattern general
1632803 1632803 30622564
Duration: 0.388145 seconds

 threads : 2
%%MatrixMarket matrix coordinate pattern general
1632803 1632803 30622564
Duration: 0.276337 seconds

 threads : 3
%%MatrixMarket matrix coordinate pattern general
1632803 1632803 30622564
Duration: 0.197063 seconds

 threads : 4
%%MatrixMarket matrix coordinate pattern general
1632803 1632803 30622564
Duration: 0.220620 seconds

 threads : 8
%%MatrixMarket matrix coordinate pattern general
1632803 1632803 30622564
Duration: 0.281633 seconds
```
If not, try using sudo for building and running the executables.
If you don't want to run every matrix given, you can comment multiple lines out by choosing them and using the combination "ctrl + /".