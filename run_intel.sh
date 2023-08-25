#!/bin/bash

## JOB NAME
#PBS -N intel_20000
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
module load intel-2018

# ENVIRONMENT VARIABLE FOR ACCESSING THE WORKING DIRECTORY WITH PBS VARIABLE
cd $PBS_O_WORKDIR

# WRITE IN NODES.TXT FILE, THE NODES ON WHICH THE RUN HAS BEEN LAUNCHED
#cat ${PBS_NODEFILE} > /scratch/scratch_data/deepakagg/queue_testing/nodes.txt

# RUN COMMAND BASED ON CODE/APPLICATION
#gfortran -mcmodel=medium -o FortranBLAS20000 FortranBLAS.f90 -lblas
ifort -mcmodel=medium -o BasicMatrix_intel20000  BasicMatrixMultiplication_intel.f90

./BasicMatrix_intel20000
#time mpirun -np 40 --machinefile $PBS_NODEFILE hostname > /scratch/scratch_data/deepakagg/queue_testing/output.txt
