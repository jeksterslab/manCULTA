#! /bin/bash

#SBATCH --job-name=sum
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=sum.out
#SBATCH --error=sum.err

# Define project variables
PROJECT=/scratch/$USER/manCULTA
SIF=/scratch/$USER/manCULTA/.sif/docs-mplus.sif

# run

cd ${PROJECT}/.sim || exit
apptainer exec ${SIF} Rscript sum.R
