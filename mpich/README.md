# mpich
The Docker image `mpich` relies on Debian Bullseye (Slim) and contains MPICH 4.0.3.
It allows you to build and run your MPI programs in a docker container without the need to install MPICH or OpenMPI on your machine.
The Dockerfile is inspired by [mfisherman](https://github.com/mfisherman/docker).

## Tools
The following tools are installed:
- MPICH compiler (mpicc and mpicxx) and mpirun
- gcc and g++

## How to use
Run the following command:
```
$ docker run --rm -it -v $(pwd):/project mpich:latest
```
It will automatically download the docker image to your system and run it.
The argument `-it` allows you to run the container in interactive mode and will open a shell.
Further, the command mounts the directory, from where you run the command above, into the folder `/project`of the container.
That way you can use your favorite editor to write your code an run `mpicc`and `mpiccxx`in the container.


