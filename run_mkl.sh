#!/bin/bash

## JOB NAME
#PBS -N mkl_20000
## QUEUE NAME
#PBS -q serialq
## COMPUTE RESOURCES REQUESTED FOR THE JOB SELECT = NO. OF CHUNKS/NODES, NCPUS = NO. OF CORES PER CHUNK/NODE
#PBS -l select=1:ncpus=1:host=cn230
## SPECIFY THE EXECUTION TIME LIMIT FOR THE CODE/APPLICATION IN HRS:MINS:SECS FORMAT
#PBS -l walltime=48:00:00
## JOIN THE OUTPUT AND ERROR FILES INTO A SINGLE FILE WITH NAME <JOBNAME>.O<JOBID>
#PBS -j oe
## EXPORT ALL ENVIRONMENT VARIABLES
#PBS -V
#EMAIL IS SENT WHEN THE JOB STARTS, TERMINATES AND ABORTS
#PBS -m bea
## SPECIFY EMAIL ADDRESS FOR NOTIFICATIONS
##PBS -M abc@ipr.res.in


#module load intel-2019
module load intel18/mkl
module load intel-2018

source /home/application/intel2018u4/compilers_and_libraries_2018.5.274/linux/mkl/bin/mklvars.sh intel64

# ENVIRONMENT VARIABLE FOR ACCESSING THE WORKING DIRECTORY WITH PBS VARIABLE
cd $PBS_O_WORKDIR

# WRITE IN NODES.TXT FILE, THE NODES ON WHICH THE RUN HAS BEEN LAUNCHED
#cat ${PBS_NODEFILE} > /scratch/scratch_data/deepakagg/queue_testing/nodes.txt

# RUN COMMAND BASED ON CODE/APPLICATION
ifort -mcmodel=medium -o FortranMKL20000 FortranMKL.f90 -I/home/application/intel2018u4/compilers_and_libraries_2018.5.274/linux/mkl/include/intel64/ilp64 -L${MKLROOT}/lib -lmkl_rt -lpthread -lm -ldl

#gfortran -mcmodel=medium -o  BasicMatrixMultiplication.f90

./FortranMKL20000
#time mpirun -np 40 --machinefile $PBS_NODEFILE hostname > /scratch/scratch_data/deepakagg/queue_testing/output.txt